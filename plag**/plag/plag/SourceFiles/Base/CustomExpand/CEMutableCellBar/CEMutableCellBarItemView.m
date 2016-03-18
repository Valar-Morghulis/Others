//
//  CEMutableCellBarItemView.m
//  ShoppingInLZ
//
//  Created by MaYing on 14-5-21.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import "CEMutableCellBarItemView.h"

@implementation CEMutableCellBarItemView
@synthesize _data;
@synthesize _delegate;


-(void)dealloc
{
    self._data = 0;
    [super dealloc];
}
-(void)set_data:(NSDictionary *)data
{
    if(_data != data)
    {
        if(_data) [_data release];
        _data = data;
        if(_data) [_data retain];
        [self parseData];
    }
}
-(void)parseData
{
}

-(void)setSelected:(BOOL)animated
{
    if(self._delegate && animated)
    {
        [self._delegate itemSelected:self data:self._data];
    }
}
-(void)setUnselected:(BOOL)animated
{
    if(self._delegate && animated)
    {
        [self._delegate itemUnselected:self data:self._data];
    }
}

@end
