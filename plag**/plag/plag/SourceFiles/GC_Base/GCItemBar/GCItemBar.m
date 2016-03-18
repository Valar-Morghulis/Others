//
//  GCItemBar.m
//  plag
//
//  Created by MaYing on 15/6/3.
//  Copyright (c) 2015年 xiaofu. All rights reserved.
//

#import "GCItemBar.h"

@implementation GCItemBar

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self._prototypeNavBarItemView = [[[GCItemBarItemView alloc] initWithFrame:CGRectZero] autorelease];
    }
    return self;
}
@end
