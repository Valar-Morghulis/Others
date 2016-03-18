//
//  CTRefreshBaseView.h
//  CTRefresh
//  
//  Created by CT on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.

#import <UIKit/UIKit.h>

/**
 枚举
 */
// 控件的刷新状态
typedef enum {
	CTRefreshStatePulling = 1, // 松开就可以进行刷新的状态
	CTRefreshStateNormal = 2, // 普通状态
	CTRefreshStateRefreshing = 3, // 正在刷新中的状态
    CTRefreshStateWillRefreshing = 4
} CTRefreshState;

// 控件的类型
typedef enum {
    CTRefreshViewTypeHeader = -1, // 头部控件
    CTRefreshViewTypeFooter = 1 // 尾部控件
} CTRefreshViewType;

@class CTRefreshBaseView;

/**
 回调的Block定义
 */
// 开始进入刷新状态就会调用
typedef void (^BeginRefreshingBlock)(CTRefreshBaseView *refreshView);
// 刷新完毕就会调用
typedef void (^EndRefreshingBlock)(CTRefreshBaseView *refreshView);
// 刷新状态变更就会调用
typedef void (^RefreshStateChangeBlock)(CTRefreshBaseView *refreshView, CTRefreshState state);

/**
 代理的协议定义
 */
@protocol CTRefreshBaseViewDelegate <NSObject>
@optional
// 开始进入刷新状态就会调用
- (void)refreshViewBeginRefreshing:(CTRefreshBaseView *)refreshView;
// 刷新完毕就会调用
- (void)refreshViewEndRefreshing:(CTRefreshBaseView *)refreshView;
// 刷新状态变更就会调用
- (void)refreshView:(CTRefreshBaseView *)refreshView stateChange:(CTRefreshState)state;
@end

/**
 类的声明
 */
@interface CTRefreshBaseView : UIView
{
    // 父控件一开始的contentInset
    UIEdgeInsets _scrollViewInitInset;
    // 父控件
     UIScrollView *_scrollView;
    
    // 子控件
     UILabel *_lastUpdateTimeLabel;
	 UILabel *_statusLabel;
     UIImageView *_arrowImage;
	 UIActivityIndicatorView *_activityView;
    
    // 状态
    CTRefreshState _state;
}

// 构造方法
- (id)initWithScrollView:(UIScrollView *)scrollView;
// 设置要显示的父控件
@property (nonatomic, assign) UIScrollView *_scrollView;

// 内部的控件
@property (nonatomic, retain) UILabel *_lastUpdateTimeLabel;
@property (nonatomic, retain) UILabel *_statusLabel;
@property (nonatomic, retain) UIImageView *_arrowImage;

// Block回调
@property (nonatomic, copy) BeginRefreshingBlock beginRefreshingBlock;
@property (nonatomic, copy) RefreshStateChangeBlock refreshStateChangeBlock;
@property (nonatomic, copy) EndRefreshingBlock endStateChangeBlock;
// 代理
@property (nonatomic, assign) id<CTRefreshBaseViewDelegate> _delegate;

// 是否正在刷新
@property (nonatomic, readonly, getter=isRefreshing) BOOL refreshing;
// 开始刷新
- (void)beginRefreshing;
// 结束刷新
- (void)endRefreshing;
// 合理的Y值
- (CGFloat)validY;
// view的类型
- (CTRefreshViewType)viewType;
/**
 交给子类去实现 和 调用
 */
- (void)setState:(CTRefreshState)state;
- (int)totalDataCountInScrollView;
@end