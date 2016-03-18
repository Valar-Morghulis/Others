//
//  CTTableView.h
//  XY_Wallet
//
//  Created by yaoyongping on 13-1-17.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTRefreshTableHeaderView.h"
@class CTTableView;
@protocol CTTableViewDelegate<NSObject>

@optional
-(void)CTTableViewReloadData:(CTTableView *)tableView;
-(void)CTTableViewReloadHistoryData:(CTTableView *)tableView;
@end


@interface CTTableView : UITableView<CTRefreshTableHeaderDelegate,UIScrollViewDelegate>{
    CTRefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    BOOL _reloadingHistory;
    id<CTTableViewDelegate> tableViewDelegate;
    BOOL _autoLoad;
    BOOL autoLoad;
}
@property(nonatomic,assign)id<CTTableViewDelegate> tableViewDelegate;
@property(nonatomic)BOOL autoLoad;
-(void)useRefreshHeader;
- (void)doneLoadingTableViewData;
- (void)doneLoadingTableViewData:(UIScrollView *)scrollview;
-(void)doneLoadingHistoryDataWithLoadingOver:(BOOL)over;
-(void)scrollToBottom:(BOOL)animated;
@end
