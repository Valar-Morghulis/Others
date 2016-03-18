//
//  CEMutableCellBar.m
//  ShoppingInLZ
//
//  Created by MaYing on 14-5-21.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import "CEMutableCellBar.h"

#define default_item_width  80
#define default_item_height 40
#define default_colNumPerScreen 3
#define default_rowNumPerScreen 3

@implementation CEMutableCellBar

@synthesize _data;
@synthesize _delegate;
@synthesize _itemHeight;
@synthesize _itemWidth;
@synthesize _scrollView;
@synthesize _colNumPerScreen;
@synthesize _rowNumPerScreen;
@synthesize _key;
@synthesize _currentItem;
@synthesize _prototypeItem;

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self._itemWidth = default_item_width;
        self._itemHeight = default_item_height;
        self._colNumPerScreen = default_colNumPerScreen;
        self._rowNumPerScreen = default_rowNumPerScreen;
        self._key = @"id";
        self._prototypeItem = [[[CEMutableCellBarItemView alloc] init] autorelease];
        
        self._scrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)] autorelease];
        [self addSubview:self._scrollView];
        self._scrollView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)dealloc
{
    self._prototypeItem = 0;
    self._currentItem = 0;
    self._data = 0;
    self._scrollView = 0;
    self._key = 0;
    [super dealloc];
}
-(void)clear
{
    NSArray * array = [self._scrollView subviews];
    for(UIView * view in array)
    {
        [view removeFromSuperview];
    }
    self._scrollView.contentSize = self._scrollView.frame.size;
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
    [self clear];
    if(self._data)
    {
        CGRect scrollFrame = self._scrollView.frame;
        float disX = (scrollFrame.size.width - self._colNumPerScreen * self._itemWidth) / (self._colNumPerScreen - 1);
        float disY = 0;//(scrollFrame.size.height - self._rowNumPerScreen * self._itemHeight) / (self._rowNumPerScreen - 1);
        float originX = 0;
        float originY = 0;
        NSArray * array = [self._data objectForKey:@"array"];
        //
        int count = [array count];
        for(int index = 0;index < count;)
        {
            for(int i = 0; i < self._colNumPerScreen && index < count;i++,index++)
            {
                NSDictionary * dic = [array objectAtIndex:index];
                CEMutableCellBarItemView * itemView = [[[[self._prototypeItem class] alloc] initWithFrame:CGRectMake(originX, originY, self._itemWidth, self._itemHeight)] autorelease];
               
                itemView._delegate = self;
                itemView._data = dic;
                [self._scrollView addSubview:itemView];
                originX += self._itemWidth + disX;
            }//for
            originX = 0;
            originY += self._itemHeight + disY;
        }//for
        originY -= disY;
        self._scrollView.contentSize = CGSizeMake(scrollFrame.size.width, originY);
    }
}


#pragma mark CEMutableCellBarItemViewDelegate
-(void)itemSelected:(CEMutableCellBarItemView *)item data:(NSDictionary *)data
{
    if(self._currentItem && self._currentItem != item)
    {
        [self._currentItem setUnselected:FALSE];
        if(self._delegate)
        {
            [self._delegate itemUnselected:self._currentItem data:self._currentItem._data];
        }
    }
    //
    if(self._delegate)
    {
        [self._delegate itemSelected:item data:data];
    }
    self._currentItem = item;
}

-(void)itemUnselected:(CEMutableCellBarItemView *)item data:(NSDictionary *)data
{
    self._currentItem = 0;
    
    if(self._delegate)
    {
        [self._delegate itemUnselected:item data:data];
    }
}

-(CEMutableCellBarItemView *)itemWithTypeIndex:(int)typeIndex
{
    CEMutableCellBarItemView * res = 0;
    NSArray * array = [self._scrollView subviews];
    for(CEMutableCellBarItemView * item in array)
    {
        int index = [[item._data objectForKey:self._key] intValue];
        if(typeIndex == index)
        {
            res = item;
            break;
        }
    }
    return res;
}
-(void)selectItemByTypeIndex:(int)typeIndex animate:(BOOL)animate
{
    assert(self._key);
    if(self._currentItem)
    {
        [self._currentItem setUnselected:FALSE];
        self._currentItem = 0;
    }
    
    CEMutableCellBarItemView * itemView = [self itemWithTypeIndex:typeIndex];
    if(itemView)
    {
        if(!animate)
        {
            self._currentItem = itemView;
        }
        [itemView setSelected:animate];
    }
    
}

@end
