//
//  CEScrollPageControl.m
//  ShoppingInLZ
//
//  Created by MaYing on 14-5-14.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import "CEScrollPageControl.h"
#define DEFAULT_SCROLL_TIMER_DURATION 1
@implementation CEScrollPageControl
@synthesize _delegate;
@synthesize _data;
@synthesize _pageControl;
@synthesize _pageSource;
@synthesize _scrollView;
@synthesize _autoScroll;
@synthesize _autoInterval;
-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        //
        _autoScroll = FALSE;
        _autoInterval = DEFAULT_SCROLL_TIMER_DURATION;
        _isScrollForward = TRUE;
        
        self._scrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)] autorelease];
        [self addSubview:self._scrollView];
        self._scrollView.showsVerticalScrollIndicator = FALSE;
        self._scrollView.backgroundColor = [UIColor clearColor];
        self._scrollView.delegate = self;
        self._scrollView.pagingEnabled = TRUE;
        self._scrollView.showsHorizontalScrollIndicator = FALSE;
        //
        //pageControl
        float disY = 0;
        float pageControlHeight = 20;
        float pageControlOriginY = frame.size.height - disY - pageControlHeight;
        float pageControlWidth = frame.size.width;
        float pageControlOriginX = (frame.size.width - pageControlWidth) / 2;
        
        self._pageControl = [[[CEPageControl alloc] initWithFrame:CGRectMake(pageControlOriginX, pageControlOriginY, pageControlWidth, pageControlHeight)] autorelease];
        [self addSubview:self._pageControl];
        
        _pageControl._activeImage = [UIImage imageNamed:@"icon_point_action.png"];
        _pageControl._inactiveImage = [UIImage imageNamed:@"icon_point.png"];
        _pageControl._itemDis = 20;
        //
        self._pageSource = [[[CEScrollPageSource alloc] init] autorelease];
        //
        _pages = [[NSMutableArray alloc] init];
    }
    return self;
}
-(void)dealloc
{
    self._scrollView.delegate = 0;
    [self killTimer];
    self._data = 0;
    self._scrollView = 0;
    self._pageSource = 0;
    self._pageControl = 0;
    [self clear];
    [_pages release];
    [super dealloc];
}
-(void)resetTimer
{
    [self killTimer];
    [self performSelector:@selector(scrollToNextPage) withObject:0 afterDelay:self._autoInterval];//
}
-(void)killTimer
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(scrollToNextPage) object:0];
}
-(void)scrollToPageAtIndex:(int)index
{
    if(index >= 0 && index < [_pages count])
    {
        CGPoint offset = self._scrollView.contentOffset;
        offset.x = self._scrollView.frame.size.width * index;
        [self._scrollView setContentOffset:offset animated:TRUE];
        [self._pageControl updateCurrentPageIndex:index];
        if(self._delegate)
        {
            CEScrollPage *scrollPage =[self pageAtIndex:index];
            [self._delegate scrollToPage:scrollPage data:scrollPage._data];
        }

    }
}
-(void)scrollToNextPage
{
    int currentPage = [self currentPageIndex];
    int totalCount = [_pages count];
    int targetPage = 0;
    if(_isScrollForward)
    {
        targetPage = currentPage + 1;
        if(targetPage >= totalCount)
        {
            targetPage = currentPage - 1;
            _isScrollForward = FALSE;
            targetPage = targetPage >= 0 ? targetPage : 0;
        }
    }
    else
    {
        targetPage = currentPage - 1;
        if(targetPage < 0)
        {
            targetPage = currentPage + 1;
            _isScrollForward = TRUE;
            targetPage = targetPage <= totalCount - 1 ? targetPage : totalCount - 1;
        }
    }

   CGPoint offset = self._scrollView.contentOffset;
    offset.x = self._scrollView.frame.size.width * targetPage;
   [self._scrollView setContentOffset:offset animated:TRUE];
    [self._pageControl updateCurrentPageIndex:targetPage];
    if(self._delegate)
    {
        CEScrollPage *scrollPage =[self pageAtIndex:targetPage];
        [self._delegate scrollToPage:scrollPage data:scrollPage._data];
    }

    
    [self resetTimer];
  
}
-(void)set_autoInterval:(float)scrollTimerDuration
{
    _autoInterval = scrollTimerDuration;
    if(self._autoScroll)
    {
        [self resetTimer];
    }
}
-(void)set_autoScroll:(BOOL)autoScroll
{
    _autoScroll = autoScroll;
    if(_autoScroll)
        [self resetTimer];
    else
        [self killTimer];
}


-(void)set_data:(NSDictionary *)data
{
    if(data != _data)
    {
        if(_data) [_data release];
        _data = data;
        if(_data) [_data retain];
        [self parseData];
    }
}
-(void)clear
{
    [self killTimer];
    for(CEScrollPage * page in _pages)
    {
        [page removeFromSuperview];
    }
    self._scrollView.contentSize = CGSizeMake(self._scrollView.frame.size.width, self._scrollView.contentSize.height);
    self._pageControl._numberOfPages = 0;
    [_pages removeAllObjects];
}
-(void)parseData
{
    [self clear];
    if(self._data)
    {
        float scrollViewWidth = self._scrollView.frame.size.width;
        float scrollViewHeight = self._scrollView.frame.size.height;
        
        NSArray * scrollData = [self._data objectForKey:@"data"];
        if(scrollData)
        {
            float pageViewOriginX = 0;
            for(NSDictionary * dic in scrollData)
            {
                CEScrollPage * page = [self._pageSource pageInFrame:CGRectMake(pageViewOriginX, 0, scrollViewWidth, scrollViewHeight) Data:dic];
                [self._scrollView addSubview:page];
                [_pages addObject:page];
                pageViewOriginX += scrollViewWidth;
                
            }
            CGSize contentSize = self._scrollView.contentSize;
            contentSize.width = pageViewOriginX;
            self._scrollView.contentSize = contentSize;
            self._pageControl._numberOfPages = [scrollData count];
        }
        //
        if(self._autoScroll)
        {
            [self resetTimer];
        }
    }
}
-(CEScrollPage *)pageAtIndex:(int)index
{
    CEScrollPage * res = 0;
    if(index < [_pages count])
    {
        res = [_pages objectAtIndex:index];
    }
    return res;
}
-(int)currentPageIndex
{
    float width = self._scrollView.frame.size.width;
    float offsetX = self._scrollView.contentOffset.x;
    int page = offsetX / width + 0.5;
    return page;
}
-(CEScrollPage *)currentPage
{
    return [self pageAtIndex:[self currentPageIndex]];
}
#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float width = scrollView.frame.size.width;
    float offsetX = scrollView.contentOffset.x;
    int page = offsetX / width + 0.5;
    page = page > 0 ? page : 0;
    page = page < self._pageControl._numberOfPages  - 1 ? page : self._pageControl._numberOfPages - 1;
    
    [self._pageControl updateCurrentPageIndex:page];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(self._autoScroll)
    {
        [self resetTimer];
    }
    float width = scrollView.frame.size.width;
    float offsetX = scrollView.contentOffset.x;
    int page = offsetX / width + 0.5;
    
    [self._pageControl updateCurrentPageIndex:page];
    if(self._delegate)
    {
        CEScrollPage *scrollPage =[self pageAtIndex:page];
        [self._delegate scrollToPage:scrollPage data:scrollPage._data];
    }
    
}

@end
