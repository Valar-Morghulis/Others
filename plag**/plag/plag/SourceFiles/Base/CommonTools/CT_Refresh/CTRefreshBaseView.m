//
//  CTRefreshBaseView.m
//  CTRefresh
//
//  Created by CT on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "CTRefreshBaseView.h"
#import "CTRefreshConst.h"

@interface  CTRefreshBaseView()
{
    BOOL _hasInitInset;
}
/**
 交给子类去实现
 */
@end

@implementation CTRefreshBaseView
@synthesize _scrollView;
@synthesize _lastUpdateTimeLabel;
@synthesize _statusLabel;
@synthesize _arrowImage;
@synthesize _delegate;

#pragma mark 创建一个UILabel
- (UILabel *)labelWithFontSize:(CGFloat)size
{
    UILabel *label = [[[UILabel alloc] init] autorelease];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.font = [UIFont boldSystemFontOfSize:size];
    label.textColor = CTRefreshLabelTextColor;
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

#pragma mark - 初始化方法
- (id)initWithScrollView:(UIScrollView *)scrollView
{
    if (self = [super init]) {
        self._scrollView = scrollView;
    }
    return self;
}
-(void)dealloc
{
    self._scrollView = 0;
    self._arrowImage = 0;
    self._lastUpdateTimeLabel = 0;
    self._statusLabel = 0;
    [_activityView release];
    [super dealloc];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!_hasInitInset) {
        _scrollViewInitInset = _scrollView.contentInset;
    
        [self observeValueForKeyPath:CTRefreshContentSize ofObject:nil change:nil context:nil];
        
        _hasInitInset = YES;
        
        if (_state == CTRefreshStateWillRefreshing)
        {
            [self setState:CTRefreshStateRefreshing];
        }
    }
}

#pragma mark 构造方法
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        // 1.自己的属性
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor clearColor];
        
        // 2.时间标签
        [self addSubview:self._lastUpdateTimeLabel = [self labelWithFontSize:12]];
        
        // 3.状态标签
        [self addSubview:self._statusLabel = [self labelWithFontSize:13]];
        
        // 4.箭头图片
        UIImageView *arrowImage = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:kSrcName(@"arrow.png")]] autorelease];
        arrowImage.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:self._arrowImage = arrowImage];
        
        // 5.指示器
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityView.bounds = arrowImage.bounds;
        activityView.autoresizingMask = arrowImage.autoresizingMask;
        [self addSubview:_activityView = activityView];
        
        // 6.设置默认状态
        [self setState:CTRefreshStateNormal];
    }
    return self;
}

#pragma mark 设置frame
- (void)setFrame:(CGRect)frame
{
    frame.size.height = CTRefreshViewHeight;
    [super setFrame:frame];
    
    CGFloat w = frame.size.width;
    CGFloat h = frame.size.height;
    if (w == 0 || _arrowImage.center.y == h * 0.5) return;
    
    CGFloat statusX = 0;
    CGFloat statusY = 5;
    CGFloat statusHeight = 20;
    CGFloat statusWidth = w;
    // 1.状态标签
    _statusLabel.frame = CGRectMake(statusX, statusY, statusWidth, statusHeight);

    // 2.时间标签
    CGFloat lastUpdateY = statusY + statusHeight + 5;
    _lastUpdateTimeLabel.frame = CGRectMake(statusX, lastUpdateY, statusWidth, statusHeight);
    
    // 3.箭头
    CGFloat arrowX = w * 0.5 - 100;
    _arrowImage.center = CGPointMake(arrowX, h * 0.5);
    
    // 4.指示器
    _activityView.center = _arrowImage.center;
}

- (void)setBounds:(CGRect)bounds
{
    bounds.size.height = CTRefreshViewHeight;
    [super setBounds:bounds];
}

#pragma mark - UIScrollView相关
#pragma mark 设置UIScrollView

-(void)set_scrollView:(UIScrollView *)scrollView
{
    if(_scrollView != scrollView)
    {
        if(_scrollView)
        {
            // 移除之前的监听器
            [_scrollView removeObserver:self forKeyPath:CTRefreshContentOffset context:nil];
            [self removeFromSuperview];
        }
        _scrollView = scrollView;
        if(_scrollView)
        {
            // 监听contentOffset
            [_scrollView addObserver:self forKeyPath:CTRefreshContentOffset options:NSKeyValueObservingOptionNew context:nil];
            [_scrollView addSubview:self];
        }
    }
    
}

#pragma mark 监听UIScrollView的contentOffset属性
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{    
    if (![CTRefreshContentOffset isEqualToString:keyPath]) return;
    
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden
        || _state == CTRefreshStateRefreshing) return;
    
    // scrollView所滚动的Y值 * 控件的类型（头部控件是-1，尾部控件是1）
    CGFloat offsetY = _scrollView.contentOffset.y * self.viewType;
    CGFloat validY = self.validY;
    if (offsetY <= validY) return;
    
    if (_scrollView.isDragging) {
        CGFloat validOffsetY = validY + CTRefreshViewHeight;
        if (_state == CTRefreshStatePulling && offsetY <= validOffsetY) {
            // 转为普通状态
            [self setState:CTRefreshStateNormal];
            // 通知代理
            if (_delegate && [_delegate respondsToSelector:@selector(refreshView:stateChange:)]) {
                [_delegate refreshView:self stateChange:CTRefreshStateNormal];
            }
            
            // 回调
            if (_refreshStateChangeBlock) {
                _refreshStateChangeBlock(self, CTRefreshStateNormal);
            }
        } else if (_state == CTRefreshStateNormal && offsetY > validOffsetY) {
            // 转为即将刷新状态
            [self setState:CTRefreshStatePulling];
            // 通知代理
            if (_delegate && [_delegate respondsToSelector:@selector(refreshView:stateChange:)]) {
                [_delegate refreshView:self stateChange:CTRefreshStatePulling];
            }
            
            // 回调
            if (_refreshStateChangeBlock) {
                _refreshStateChangeBlock(self, CTRefreshStatePulling);
            }
        }
    } else { // 即将刷新 && 手松开
        if (_state == CTRefreshStatePulling) {
            // 开始刷新
            [self setState:CTRefreshStateRefreshing];
            // 通知代理
            if (_delegate && [_delegate respondsToSelector:@selector(refreshView:stateChange:)]) {
                [_delegate refreshView:self stateChange:CTRefreshStateRefreshing];
            }
            
            // 回调
            if (_refreshStateChangeBlock) {
                _refreshStateChangeBlock(self, CTRefreshStateRefreshing);
            }
        }
    }
}

#pragma mark 设置状态
- (void)setState:(CTRefreshState)state
{
    if (_state != CTRefreshStateRefreshing) {
        // 存储当前的contentInset
        _scrollViewInitInset = _scrollView.contentInset;
    }
    
    // 1.一样的就直接返回
    if (_state == state) return;
    
    // 2.根据状态执行不同的操作
    switch (state) {
		case CTRefreshStateNormal: // 普通状态
            // 显示箭头
            _arrowImage.hidden = NO;
            // 停止转圈圈
			[_activityView stopAnimating];
            
            // 说明是刚刷新完毕 回到 普通状态的
            if (CTRefreshStateRefreshing == _state) {
                // 通知代理
                if (_delegate && [_delegate respondsToSelector:@selector(refreshViewEndRefreshing:)]) {
                    [_delegate refreshViewEndRefreshing:self];
                }
                
                // 回调
                if (_endStateChangeBlock) {
                    _endStateChangeBlock(self);
                }
            }
            
			break;
            
        case CTRefreshStatePulling:
            break;
            
		case CTRefreshStateRefreshing:
            // 开始转圈圈
			[_activityView startAnimating];
            // 隐藏箭头
			_arrowImage.hidden = YES;
            _arrowImage.transform = CGAffineTransformIdentity;
            
            // 通知代理
            if (_delegate && [_delegate respondsToSelector:@selector(refreshViewBeginRefreshing:)]) {
                [_delegate refreshViewBeginRefreshing:self];
            }
            
            // 回调
            if (_beginRefreshingBlock) {
                _beginRefreshingBlock(self);
            }
			break;
        default:
            break;
	}
    
    // 3.存储状态
    _state = state;
}

#pragma mark - 状态相关
#pragma mark 是否正在刷新
- (BOOL)isRefreshing
{
    return CTRefreshStateRefreshing == _state;
}
#pragma mark 开始刷新
- (void)beginRefreshing
{
    if (self.window) {
        [self setState:CTRefreshStateRefreshing];
    } else {
        _state = CTRefreshStateWillRefreshing;
    }
}
#pragma mark 结束刷新
- (void)endRefreshing
{
    double delayInSeconds = self.viewType == CTRefreshViewTypeFooter ? 0.3 : 0.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self setState:CTRefreshStateNormal];
    });
}

#pragma mark - 随便实现
- (CGFloat)validY { return 0;}
- (CTRefreshViewType)viewType {return CTRefreshViewTypeHeader;}


- (int)totalDataCountInScrollView
{
    int totalCount = 0;
    if ([self._scrollView isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self._scrollView;
        
        for (int section = 0; section<tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    } else if ([self._scrollView isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self._scrollView;
        
        for (int section = 0; section<collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}
@end