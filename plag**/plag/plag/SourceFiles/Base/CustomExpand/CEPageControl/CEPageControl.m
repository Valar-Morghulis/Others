//
//  CEPageControl.m
//  GuangCity
//
//  Created by MaYing on 14-10-23.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import "CEPageControl.h"

@implementation CEPageControl
@synthesize _activeImage;
@synthesize _currentIndex;
@synthesize _inactiveImage;
@synthesize _itemDis;
@synthesize _numberOfPages;

-(void)dealloc
{
    self._numberOfPages = 0;//
    self._activeImage = 0;
    self._inactiveImage = 0;
    [_dots release];
    _dots = 0;
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _numberOfPages = 0;
        _currentIndex = 0;
        _dots = [[NSMutableArray alloc] init];
    }
    return self;
}
-(void)set_numberOfPages:(int)numberOfPages
{
    _numberOfPages = numberOfPages;
    [self resetDots];
}
-(void)set_itemDis:(float)itemDis
{
    _itemDis = itemDis;
    [self resetDots];
}
-(void)set_inactiveImage:(UIImage *)inactiveImage
{
    if(_inactiveImage != inactiveImage)
    {
        if(_inactiveImage) [_inactiveImage release];
        _inactiveImage = inactiveImage;
        if(_inactiveImage) [_inactiveImage retain];
        [self updateDots:_currentIndex];
    }
}
-(void)set_activeImage:(UIImage *)activeImage
{
    if(_activeImage != activeImage)
    {
        if(_activeImage) [_activeImage release];
        _activeImage = activeImage;
        if(_activeImage) [_activeImage retain];
        [self updateDots:_currentIndex];
    }
}

-(void)resetDots
{
    [self removeAllDots];
    CGRect frame = self.frame;
    float itemHeight = frame.size.height;
    float itemWidth = itemHeight;
    float originX = (frame.size.width - itemWidth * _numberOfPages - _itemDis * (_numberOfPages -1)) / 2;
    float originY = 0;
    for(int i = 0;i < _numberOfPages;i++)
    {
        UIImageView  * imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(originX, originY, itemWidth, itemHeight)] autorelease];
        [self addSubview:imageView];
        [_dots addObject:imageView];
        imageView.image = self._inactiveImage;
        originX += itemWidth + _itemDis;
    }
    [self updateDots:_currentIndex];//
    
}
-(void)updateDots:(int)newIndex
{
    if(_currentIndex < _numberOfPages)
    {
        UIImageView * imageView = [_dots objectAtIndex:_currentIndex];
        imageView.image = self._inactiveImage;
    }
    _currentIndex = newIndex;
    if(_currentIndex < _numberOfPages)
    {
        UIImageView * imageView = [_dots objectAtIndex:_currentIndex];
        imageView.image = self._activeImage;
    }
}
-(void)removeAllDots
{
    for(UIImageView * view in _dots)
    {
        [view removeFromSuperview];
    }
    [_dots removeAllObjects];
}


-(void)updateCurrentPageIndex:(int)page
{
    [self updateDots:page];
}

@end
