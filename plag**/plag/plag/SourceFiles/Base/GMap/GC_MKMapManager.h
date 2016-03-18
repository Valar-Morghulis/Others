//
//  GC_MKMapManager.h
//  HK3_BMap
//
//  Created by MaYing on 13-7-29.
//  Copyright (c) 2013年 MaYing. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GC_MKMapManagerDelegate


@end

@interface GC_MKMapManager : NSObject

-(BOOL)start:(NSString*)key generalDelegate:(id<GC_MKMapManagerDelegate>)delegate;
-(BOOL)stop;
@end
