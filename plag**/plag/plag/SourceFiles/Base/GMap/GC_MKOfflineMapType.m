//
//  GC_MKOfflineMapType.m
//  HK3_BMap
//
//  Created by MaYing on 13-8-3.
//  Copyright (c) 2013年 MaYing. All rights reserved.
//

#import "GC_MKOfflineMapType.h"


@implementation GC_MKOLSearchRecord
@synthesize cityName;
@synthesize cityID;
@synthesize childCities;
@synthesize size;
@synthesize cityType;

-(void)dealloc
{
    self.childCities = 0;
    self.cityName = 0;
    
    [super dealloc];
}
@end

@implementation GC_MKOLUpdateElement
@synthesize cityName;
@synthesize cityID;
@synthesize size;
@synthesize serversize;
@synthesize ratio;
@synthesize status;
@synthesize update;
@synthesize pt;

-(void)dealloc
{
    self.cityName = 0;
    [super dealloc];
}
@end

