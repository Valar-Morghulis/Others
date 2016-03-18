//
//  CEScrollPageSource.m
//  ShoppingInLZ
//
//  Created by MaYing on 14-5-14.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import "CEScrollPageSource.h"

@implementation CEScrollPageSource
@synthesize _pageDelegate;
-(CEScrollPage *)pageInFrame:(CGRect)frame Data:(NSDictionary *)data
{
    CEScrollPage * res = [[[CEScrollPage alloc] initWithFrame:frame] autorelease];
    res._delegate = self._pageDelegate;
    res._data = data;
    return res;
}
@end
