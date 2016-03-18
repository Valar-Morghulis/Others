//
//  CTRefreshFooterView.m
//  CTRefresh
//
//  Created by CT on 13-2-26.
//  Copyright (c) 2013年 itcast. All rights reserved.
//  上拉加载更多

#import "CTRefreshFooterView.h"
#import "CTRefreshConst.h"

@interface CTRefreshFooterView()
//{
//    BOOL _withoutIdle;
//}
{
    int _lastRefreshCount;
}
@end

@implementation CTRefreshFooterView

+ (CTRefreshFooterView *)footer
{
    return [[[CTRefreshFooterView alloc] init] autorelease];
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame: frame]) {
        // 移除刷新时间
		[_lastUpdateTimeLabel removeFromSuperview];
        self._lastUpdateTimeLabel = nil;
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    CGFloat h = frame.size.height;
    if (_statusLabel.center.y != h * 0.5) {
        CGFloat w = frame.size.width;
        _statusLabel.center = CGPointMake(w * 0.5, h * 0.5);
    }
}

#pragma mark - UIScrollView相关
#pragma mark 重写设置ScrollView
-(void)set_scrollView:(UIScrollView *)scrollView
{
    UIScrollView * oldScrollView = self._scrollView;
    
    [super set_scrollView:scrollView];
    
    if(oldScrollView != scrollView)
    {
        if(oldScrollView)
        {
            // 1.移除以前的监听器
            [oldScrollView removeObserver:self forKeyPath:CTRefreshContentSize context:nil];
        }
        if(scrollView)
        {
            // 2.监听contentSize
            [scrollView addObserver:self forKeyPath:CTRefreshContentSize options:NSKeyValueObservingOptionNew context:nil];
        }
    }
    // 4.重新调整frame
    [self adjustFrame];
}

#pragma mark 监听UIScrollView的属性
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden) return;
    
    if ([CTRefreshContentSize isEqualToString:keyPath]) {
        [self adjustFrame];
    }
}

#pragma mark 重写调整frame
- (void)adjustFrame
{
    // 内容的高度
    CGFloat contentHeight = _scrollView.contentSize.height;
    // 表格的高度
    CGFloat scrollHeight = _scrollView.frame.size.height - _scrollViewInitInset.top - _scrollViewInitInset.bottom;
    CGFloat y = MAX(contentHeight, scrollHeight);
    // 设置边框
    self.frame = CGRectMake(0, y, _scrollView.frame.size.width, CTRefreshViewHeight);
}

#pragma mark - 状态相关
#pragma mark 设置状态
- (void)setState:(CTRefreshState)state
{
    if (_state == state) return;
    CTRefreshState oldState = _state;
    
    [super setState:state];
    
	switch (state)
    {
		case CTRefreshStatePulling:
        {
            _statusLabel.text = CTRefreshFooterReleaseToRefresh;
            
            [UIView animateWithDuration:CTRefreshAnimationDuration animations:^{
                _arrowImage.transform = CGAffineTransformIdentity;
                UIEdgeInsets inset = _scrollView.contentInset;
                inset.bottom = _scrollViewInitInset.bottom;
                _scrollView.contentInset = inset;
            }];
			break;
        }
            
		case CTRefreshStateNormal:
        {
            _statusLabel.text = CTRefreshFooterPullToRefresh;
            
            // 刚刷新完毕
            CGFloat animDuration = CTRefreshAnimationDuration;
            CGFloat deltaH = [self contentBreakView];
            CGPoint tempOffset;
            
            int currentCount = [self totalDataCountInScrollView];
            if (CTRefreshStateRefreshing == oldState && deltaH > 0 && currentCount != _lastRefreshCount) {
                tempOffset = _scrollView.contentOffset;
                animDuration = 0;
            }
            
            [UIView animateWithDuration:animDuration animations:^{
                _arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
                UIEdgeInsets inset = _scrollView.contentInset;
                inset.bottom = _scrollViewInitInset.bottom;
                _scrollView.contentInset = inset;
            }];
            
            if (animDuration == 0) {
                _scrollView.contentOffset = tempOffset;
            }
			break;
        }
            
        case CTRefreshStateRefreshing:
        {
            // 记录刷新前的数量
            _lastRefreshCount = [self totalDataCountInScrollView];
            
            _statusLabel.text = CTRefreshFooterRefreshing;
            _arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
            [UIView animateWithDuration:CTRefreshAnimationDuration animations:^{
                UIEdgeInsets inset = _scrollView.contentInset;
                CGFloat bottom = CTRefreshViewHeight + _scrollViewInitInset.bottom;
                CGFloat deltaH = [self contentBreakView];
                if (deltaH < 0) { // 如果内容高度小于view的高度
                    bottom -= deltaH;
                }
                inset.bottom = bottom;
                _scrollView.contentInset = inset;
            }];
			break;
        }
            
        default:
            break;
	}
}


#pragma mark 获得scrollView的内容 超出 view 的高度
- (CGFloat)contentBreakView
{
    CGFloat h = _scrollView.frame.size.height - _scrollViewInitInset.bottom - _scrollViewInitInset.top;
    return _scrollView.contentSize.height - h;
}

#pragma mark - 在父类中用得上
// 合理的Y值(刚好看到上拉刷新控件时的contentOffset.y，取相反数)
- (CGFloat)validY
{
    CGFloat deltaH = [self contentBreakView];
    if (deltaH > 0) {
        return deltaH -_scrollViewInitInset.top;
    } else {
        return -_scrollViewInitInset.top;
    }
}

// view的类型
- (CTRefreshViewType)viewType
{
    return CTRefreshViewTypeFooter;
}

@end