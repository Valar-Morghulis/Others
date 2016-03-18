//
//  CTTableView.m
//  XY_Wallet
//
//  Created by yaoyongping on 13-1-17.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "CTTableView.h"
#import "CTUtility.h"

@implementation CTTableView{
    UIButton *_bottomStatusView;
    UILabel *_lblBottomStatus;
    UIActivityIndicatorView *_activityView;
}
@synthesize tableViewDelegate,autoLoad=_autoLoad;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)useRefreshHeader{
    if (_refreshHeaderView==nil) {
        _refreshHeaderView=[[CTRefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.bounds.size.height, self.frame.size.width, self.bounds.size.height)];
        _refreshHeaderView.delegate=self;
        [self addSubview:_refreshHeaderView];
    }
}

- (void)reloadTableViewDataSource{
	
        //  should be calling your tableviews data source model to reload
        //  put here just for demo
	
	if ([tableViewDelegate respondsToSelector:@selector(CTTableViewReloadData:)]) {
        [tableViewDelegate CTTableViewReloadData:self];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	[_refreshHeaderView IHRefreshScrollViewDidScroll:scrollView];
    if (_autoLoad) {
        
        int count=[self numberOfRowsInSection:0];
        NSIndexPath *indexpath=[NSIndexPath indexPathForRow:count-1 inSection:0];
        UITableViewCell *cell=[self cellForRowAtIndexPath:indexpath];
        if (cell!=nil) {
            if (self.contentSize.height>self.frame.size.height) {
                [_bottomStatusView setHidden:NO];
                CGRect rect=cell.frame;
                CGRect bottomRect=_bottomStatusView.frame;
                bottomRect.origin.y=rect.origin.y+rect.size.height;
                [_bottomStatusView setFrame:bottomRect];
                
                [self setContentSize:CGSizeMake(rect.size.width, _bottomStatusView.frame.origin.y+_bottomStatusView.frame.size.height)];
            }
        }
        if (!_reloadingHistory) {
            if (self.contentSize.height>self.frame.size.height) {
                CGPoint p=scrollView.contentOffset;
                if (p.y+self.frame.size.height>self.contentSize.height+20) {
                    [_lblBottomStatus setText:@"松开后自动加载数据"];
                }else{
                    [_lblBottomStatus setText:@"上拉加载数据"];
                }
            }
            
        }
        
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView IHRefreshScrollViewDidEndDragging:scrollView];
	if (_autoLoad) {
        CGPoint p=scrollView.contentOffset;
        if (p.y+self.frame.size.height>self.contentSize.height+20) {
            [self loadHistory:nil];
        }
    }
}

-(void)setAutoLoad:(BOOL)load{
    _autoLoad=load;
    UIButton *v=[[UIButton alloc] initWithFrame:CGRectMake(0, -1000, self.frame.size.width, 70)];
    UILabel *lbl=[[UILabel alloc ] initWithFrame:CGRectMake(0, (v.frame.size.height-20)/2, v.frame.size.width, 20)];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setFont:[UIFont systemFontOfSize:15]];
    [lbl setTextAlignment:NSTextAlignmentCenter];
    [lbl setTextColor:[UIColor grayColor]];
    [v addSubview:lbl];
    _lblBottomStatus=lbl;
    [lbl release];
    [self addSubview:v];
    _bottomStatusView=v;
    [v release];
    
    UIActivityIndicatorView *activityView=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, (v.frame.size.height-20)/2, 20, 20)];
    [activityView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [_bottomStatusView addSubview:activityView];
    _activityView=activityView;
    
    [activityView release];
    [_bottomStatusView addTarget:self action:@selector(loadHistory:) forControlEvents:UIControlEventTouchUpInside];
    
    [_bottomStatusView setHidden:YES];
}

-(void)loadHistory:(id)sender{
    if (!_bottomStatusView.hidden && !_reloadingHistory) {
        if ([tableViewDelegate respondsToSelector:@selector(CTTableViewReloadHistoryData:)]) {
            _reloadingHistory=YES;
            [_activityView setHidden:NO];
            [_activityView startAnimating];
            [_lblBottomStatus setText:@"正在加载数据..."];
            [self setActivitviewFrame];
            [tableViewDelegate CTTableViewReloadHistoryData:self];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    if (self.autoLoad) {
//        if (!_reloadingHistory) {
//            
//            CGPoint p=scrollView.contentOffset;
//            if (p.y+self.frame.size.height==self.contentSize.height) {
//                if ([tableViewDelegate respondsToSelector:@selector(CTTableViewReloadHistoryData:)]) {
//                    _reloadingHistory=YES;
//                    [tableViewDelegate CTTableViewReloadHistoryData:self];
//                }
//            }
//        }
//        
//    }
}

-(void)doneLoadingHistoryDataWithLoadingOver:(BOOL)over{
    _reloadingHistory=NO;
    _reloadingHistory=over;
    [_activityView stopAnimating];
    [_activityView setHidden:YES];
    CGSize size=self.contentSize;
    if (size.height>self.frame.size.height) {
//        [_bottomStatusView setHidden:YES];
        
        if (over) {
            [_bottomStatusView setHidden:NO];
            [_lblBottomStatus setText:@"已经加载了所有数据"];
        }else{
            [_lblBottomStatus setText:@"上拉加载数据"];
            [_bottomStatusView setHidden:YES];
        }
        [self setActivitviewFrame];
    }else{
        
        [_bottomStatusView setHidden:YES];
    }
}

-(void)setActivitviewFrame{
    CGRect rect=_activityView.frame;
    CGSize size=[CTUtility GetSizeByText:_lblBottomStatus.text sizeOfFont:15 height:20];
    rect.origin.x=(self.frame.size.width-size.width)/2.0f-25;
    [_activityView setFrame:rect];
}

-(void)doneLoadingHistoryData{
    _reloadingHistory=NO;
    CGSize size=self.contentSize;
    if (size.height>self.frame.size.height) {
        
    }
}

- (void)doneLoadingTableViewData{
	
        //  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView IHRefreshScrollViewDataSourceDidFinishedLoading:self];
//	[self reloadData];
	
}

-(void)doneLoadingTableViewData:(UIScrollView *)scrollview{
    _reloading = NO;
	[_refreshHeaderView IHRefreshScrollViewDataSourceDidFinishedLoading:scrollview];
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)CTRefreshTableHeaderDidTriggerRefresh:(CTRefreshTableHeaderView*)view{
	_reloading = YES;
	[self reloadTableViewDataSource];
//	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)CTRefreshTableHeaderDataSourceIsLoading:(CTRefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)CTRefreshTableHeaderDataSourceLastUpdated:(CTRefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

-(void)scrollToBottom:(BOOL)animated
{
    CGSize contentsize=self.contentSize;
    if (contentsize.height>self.frame.size.height) {
        float offsety=contentsize.height-self.frame.size.height;
        [self setContentOffset:CGPointMake(0, offsety) animated:animated];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)dealloc{
    tableViewDelegate=nil;
    [_refreshHeaderView release];
    [super dealloc];
}

@end
