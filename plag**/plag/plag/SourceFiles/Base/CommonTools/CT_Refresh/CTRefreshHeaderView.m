//
//  CTRefreshHeaderView.m
//  CTRefresh
//
//  Created by CT on 13-2-26.
//  Copyright (c) 2013年 itcast. All rights reserved.
//  下拉刷新

#import "CTRefreshConst.h"
#import "CTRefreshHeaderView.h"

@interface CTRefreshHeaderView()
// 最后的更新时间
@property (nonatomic, retain) NSDate *_lastUpdateTime;
@end

@implementation CTRefreshHeaderView
@synthesize _lastUpdateTime;
@synthesize _refreshHeaderTimeKey;

+ (CTRefreshHeaderView *)header
{
    return [[[CTRefreshHeaderView alloc] init] autorelease];
}
-(id)initWithScrollView:(UIScrollView *)scrollView
{
    if(self = [super init])
    {
        self._refreshHeaderTimeKey = CTRefreshHeaderTimeKey;//默认
        self._scrollView = scrollView;
    }
    return self;
}
-(void)dealloc
{
    self._lastUpdateTime = 0;
    self._refreshHeaderTimeKey = 0;
    
    [super dealloc];
}
#pragma mark - UIScrollView相关
#pragma mark 重写设置ScrollView
-(void)set_scrollView:(UIScrollView *)scrollView
{
    [super set_scrollView:scrollView];
    
    // 1.设置边框
    self.frame = CGRectMake(0, - CTRefreshViewHeight, scrollView.frame.size.width, CTRefreshViewHeight);
    
    // 2.加载时间
    self._lastUpdateTime = [[NSUserDefaults standardUserDefaults] objectForKey:self._refreshHeaderTimeKey];
}

#pragma mark - 状态相关
#pragma mark 设置最后的更新时间

-(void)set_lastUpdateTime:(NSDate *)lastUpdateTime
{
    if(_lastUpdateTime)
    {
        [_lastUpdateTime release];
    }
    _lastUpdateTime = lastUpdateTime;
    if(_lastUpdateTime)
    {
        [_lastUpdateTime retain];
        // 1.归档
        [[NSUserDefaults standardUserDefaults] setObject:_lastUpdateTime forKey:self._refreshHeaderTimeKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        // 2.更新时间
    }
    [self updateTimeLabel];
}

#pragma mark 更新时间字符串
- (void)updateTimeLabel
{
    if (!_lastUpdateTime)
    {
        _lastUpdateTimeLabel.text = [NSString stringWithFormat:@"最后更新：从未"];
        return;
    }
    
    // 1.获得年月日
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit |NSMinuteCalendarUnit;
    NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:_lastUpdateTime];
    NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
    
    // 2.格式化日期
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    if ([cmp1 day] == [cmp2 day]) { // 今天
        formatter.dateFormat = @"今天 HH:mm";
    } else if ([cmp1 year] == [cmp2 year]) { // 今年
        formatter.dateFormat = @"MM-dd HH:mm";
    } else {
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    }
    NSString *time = [formatter stringFromDate:_lastUpdateTime];
    
    // 3.显示日期
    _lastUpdateTimeLabel.text = [NSString stringWithFormat:@"最后更新：%@", time];
}

#pragma mark 设置状态
- (void)setState:(CTRefreshState)state
{
    // 1.一样的就直接返回
    if (_state == state) return;
    
    // 2.保存旧状态
    CTRefreshState oldState = _state;
    
    // 3.调用父类方法
    [super setState:state];
    
    // 4.根据状态执行不同的操作
	switch (state) {
		case CTRefreshStatePulling: // 松开可立即刷新
        {
            // 设置文字
            _statusLabel.text = CTRefreshHeaderReleaseToRefresh;
            // 执行动画
            [UIView animateWithDuration:CTRefreshAnimationDuration animations:^{
                _arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
                UIEdgeInsets inset = _scrollView.contentInset;
                inset.top = _scrollViewInitInset.top;
                _scrollView.contentInset = inset;
            }];
			break;
        }
            
		case CTRefreshStateNormal: // 下拉可以刷新
        {
            // 设置文字
			_statusLabel.text = CTRefreshHeaderPullToRefresh;
            // 执行动画
            [UIView animateWithDuration:CTRefreshAnimationDuration animations:^{
                _arrowImage.transform = CGAffineTransformIdentity;
                UIEdgeInsets inset = _scrollView.contentInset;
                inset.top = _scrollViewInitInset.top;
                _scrollView.contentInset = inset;
            }];
            
            // 刷新完毕
            if (CTRefreshStateRefreshing == oldState) {
                // 保存刷新时间
                self._lastUpdateTime = [NSDate date];
            }
			break;
        }
            
		case CTRefreshStateRefreshing: // 正在刷新中
        {
            // 设置文字
            _statusLabel.text = CTRefreshHeaderRefreshing;
            // 执行动画
            [UIView animateWithDuration:CTRefreshAnimationDuration animations:^{
                _arrowImage.transform = CGAffineTransformIdentity;
                // 1.增加65的滚动区域
                UIEdgeInsets inset = _scrollView.contentInset;
                inset.top = _scrollViewInitInset.top + CTRefreshViewHeight;
                _scrollView.contentInset = inset;
                // 2.设置滚动位置
                _scrollView.contentOffset = CGPointMake(0, - _scrollViewInitInset.top - CTRefreshViewHeight);
            }];
			break;
        }
            
        default:
            break;
	}
}

#pragma mark - 在父类中用得上
// 合理的Y值(刚好看到下拉刷新控件时的contentOffset.y，取相反数)
- (CGFloat)validY
{
    return _scrollViewInitInset.top;
}

// view的类型
- (CTRefreshViewType)viewType
{
    return CTRefreshViewTypeHeader;
}
@end