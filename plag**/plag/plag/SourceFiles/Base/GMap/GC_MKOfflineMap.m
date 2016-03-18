//
//  GC_MKOfflineMap.m
//  HK3_BMap
//
//  Created by MaYing on 13-8-3.
//  Copyright (c) 2013年 MaYing. All rights reserved.
//

#import "GC_MKOfflineMap.h"

@implementation GC_MKOfflineMap
@synthesize delegate;

-(void)dealloc
{
    self.delegate = 0;
    [super dealloc];
}
- (BOOL)scan:(BOOL)deleteFailed
{
    return FALSE;
}
- (BOOL)start:(int)cityID
{
    return FALSE;
}
- (BOOL)update:(int)cityID
{
    return FALSE;
}
- (BOOL)pasue:(int)cityID
{
    return FALSE;
}
- (BOOL)remove:(int)cityID
{
    return FALSE;
}
- (NSArray*)getHotCityList
{
    return 0;
}
- (NSArray*)getOfflineCityList
{
    return 0;
}
- (NSArray*)searchCity:(NSString*)cityName
{
    return 0;
}
- (NSArray*)getAllUpdateInfo
{
    return 0;
}
- (GC_MKOLUpdateElement*)getUpdateInfo:(int)cityID
{
    return 0;
}

@end
