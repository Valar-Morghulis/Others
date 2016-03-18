//
//  GC_MKMapManager.m
//  HK3_BMap
//
//  Created by MaYing on 13-7-29.
//  Copyright (c) 2013年 MaYing. All rights reserved.
//

#import "GC_MKMapManager.h"

@implementation GC_MKMapManager
-(BOOL)start:(NSString*)key generalDelegate:(id<GC_MKMapManagerDelegate>)delegate
{
    return  TRUE;
}
-(BOOL)stop
{
    return  FALSE;
}
@end
