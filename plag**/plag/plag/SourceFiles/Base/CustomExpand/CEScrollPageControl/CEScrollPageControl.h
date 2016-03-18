//
//  CEScrollPageControl.h
//  ShoppingInLZ
//
//  Created by MaYing on 14-5-14.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CEScrollPageSource.h"
#import "CEPageControl.h"

@class CEScrollPageControl;

@protocol CEScrollPageControlDelegate
-(void)scrollToPage:(CEScrollPage *)page data:(NSDictionary *)data;
@end


//
//注意如果开启自动滚动，一定要手工关闭滚动，否则会无法释放
//

@interface CEScrollPageControl : UIView<UIScrollViewDelegate>
{
    id<CEScrollPageControlDelegate> _delegate;
    CEScrollPageSource * _pageSource;
    NSDictionary * _data;
    CEPageControl * _pageControl;
    UIScrollView * _scrollView;
    NSMutableArray * _pages;
    BOOL _autoScroll;//控制是否自动滚动
    float _autoInterval;//时间
    BOOL _isScrollForward;//正向
}
@property(nonatomic,assign) id<CEScrollPageControlDelegate> _delegate;
@property(nonatomic,retain) CEScrollPageSource * _pageSource;
@property(nonatomic,retain) NSDictionary * _data;
@property(nonatomic,retain) CEPageControl * _pageControl;
@property(nonatomic,retain) UIScrollView * _scrollView;

@property(nonatomic,readwrite) BOOL _autoScroll;//控制是否自动滚动
@property(nonatomic,readwrite) float _autoInterval;//时间
-(void)scrollToPageAtIndex:(int)index;
-(CEScrollPage *)pageAtIndex:(int)index;
-(CEScrollPage *)currentPage;
-(int)currentPageIndex;
-(void)parseData;
-(void)clear;
@end
