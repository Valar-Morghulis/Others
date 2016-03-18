//
//  CTRefreshHeaderView.h
//  CTRefresh
//
//  Created by CT on 13-2-26.
//  Copyright (c) 2013年 itcast. All rights reserved.
//  下拉刷新

#import "CTRefreshBaseView.h"

@interface CTRefreshHeaderView : CTRefreshBaseView
{
    NSString * _refreshHeaderTimeKey;
    NSDate * _lastUpdateTime;
}
+ (CTRefreshHeaderView *)header;
@property(nonatomic,retain) NSString * _refreshHeaderTimeKey;//设置key值
@end