//
//  CTFlipView.m
//  SBTickerViewDemo
//
//  Created by MaYing on 14-10-9.
//  Copyright (c) 2014年 Doubleint. All rights reserved.
//

#import "CTFlipView.h"

@implementation CTFlipView
@synthesize _curentFrameIndex;
@synthesize _frames;
@synthesize _tickLayer;
@synthesize _bottomFaceLayer;
@synthesize _topFaceLayer;
@synthesize _perspectiveDepth;

-(void)dealloc
{
    self._tickLayer = 0;
    self._frames = 0;
    self._topFaceLayer = 0;
    self._bottomFaceLayer = 0;
    [super dealloc];
}

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self._frames  = [NSMutableArray array];
        self.backgroundColor = [UIColor clearColor];
        _perspectiveDepth = 500;
    }
    return self;
}
-(UIView *)currentFrame
{
    UIView * res = 0;
    if(_curentFrameIndex < [_frames count])
    {
        res = [_frames objectAtIndex:_curentFrameIndex];
    }
    return res;
}
-(UIView *)upFrame
{
    UIView * res = 0;
    if(_curentFrameIndex + 1 < [_frames count])
    {
        res = [_frames objectAtIndex:_curentFrameIndex + 1];
    }
    return res;
}
-(UIView *)downFrame
{
    UIView * res = 0;
    if(_curentFrameIndex - 1 < [_frames count])
    {
        res = [_frames objectAtIndex:_curentFrameIndex - 1];
    }
    return res;
}
-(void)insertFrameBeforeCurrentFrame:(UIView *)frame
{
    if(self._curentFrameIndex > 0)
    {
        [self._frames insertObject:frame atIndex:self._curentFrameIndex];
        _curentFrameIndex++;
    }
    else
    {
        [self addFrameView:frame];
    }
}
-(void)insertFrameAtLastIndex:(UIView *)frame
{
    if([self._frames count] <= 0)
    {
        [self addSubview:frame];
    }
    [self._frames addObject:frame];
}
-(void)addFrameView:(UIView *)frameView
{
    if([self._frames count] > 0)
    {
        UIView * view = [self._frames objectAtIndex:0];
        [view removeFromSuperview];
    }
    frameView.frame = self.bounds;
    [self._frames insertObject:frameView atIndex:0];//添加到最头部
    //后加的显示在前
    [self addSubview:frameView];
}
-(void)removeFrameAtIndex:(int)pageIndex
{
    if(pageIndex < [self._frames count])
    {
        [self removeFrame:[self._frames objectAtIndex:pageIndex]];
    }
}
-(void)removeFrame:(UIView *)frame
{
    [frame removeFromSuperview];
    int index = [self._frames indexOfObject:frame];
    if(_curentFrameIndex >= index)
    {
        int newViewIndex = _curentFrameIndex;
        BOOL changeView = FALSE;
        if(_curentFrameIndex == index)
        {
            changeView = TRUE;
            if(_curentFrameIndex == 0)
            {
                newViewIndex++;
                if(newViewIndex >= [self._frames count])
                {
                    changeView = FALSE;
                }
            }
            else
            {
                _curentFrameIndex--;
                _curentFrameIndex = _curentFrameIndex >= 0 ? _curentFrameIndex : 0;
                newViewIndex = _curentFrameIndex;
            }
        }
        else
        {
            _curentFrameIndex--;
            _curentFrameIndex = _curentFrameIndex >= 0 ? _curentFrameIndex : 0;
            newViewIndex = _curentFrameIndex;
        }
        if(changeView)
        {
            [self addSubview:[self._frames objectAtIndex:newViewIndex]];
        }
    }
    [self._frames removeObject:frame];
}
-(int)count
{
    return [_frames count];//
}
-(void)clear
{
    _curentFrameIndex = 0;
    for(UIView * frame in _frames)
    {
        [frame removeFromSuperview];
    }
    [_frames removeAllObjects];
}

-(void)prepareFlipToIndex:(int)toIndex direction:(CTFlipDirectionType)direction
{
    UIView * oldView = [self._frames objectAtIndex:self._curentFrameIndex];
    [oldView removeFromSuperview];
    //
    
    _flipLayer = [CALayer layer];
    [_flipLayer setFrame:self.layer.bounds];
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = 1. / -self._perspectiveDepth;
    [_flipLayer setSublayerTransform:perspective];
    [self.layer addSublayer:_flipLayer];
    
    // Face layers
    // Top
    self._topFaceLayer = [[[CTFlipGradientLayer alloc] initWithStyle:CTFlipGradientLayerTypeFace segment:CTFlipGradientLayerSegmentTop] autorelease];
    [self._topFaceLayer setFrame:CGRectMake(0., 0., _flipLayer.frame.size.width, floorf(_flipLayer.frame.size.height/2))];
    // Bottom
    self._bottomFaceLayer = [[[CTFlipGradientLayer alloc] initWithStyle:CTFlipGradientLayerTypeFace segment:CTFlipGradientLayerSegmentBottom] autorelease];
    [self._bottomFaceLayer setFrame:CGRectMake(0., floorf(_flipLayer.frame.size.height / 2), _flipLayer.frame.size.width, floorf(_flipLayer.frame.size.height/2))];
    
    // Tick layer
    self._tickLayer = [[[CTFlipDoubleSidedLayer alloc] init] autorelease];
    [self._tickLayer setAnchorPoint:CGPointMake(1., 1.)];
    [self._tickLayer setFrame:CGRectMake(0., 0., _flipLayer.frame.size.width, floorf(_flipLayer.frame.size.height/2))];
    [self._tickLayer setZPosition:1.]; // Above the other ones
    self._tickLayer._frontLayer = [[[CTFlipGradientLayer alloc] initWithStyle:CTFlipGradientLayerTypeTick segment:CTFlipGradientLayerSegmentTop] autorelease];
    self._tickLayer._backLayer = [[[CTFlipGradientLayer alloc] initWithStyle:CTFlipGradientLayerTypeTick segment:CTFlipGradientLayerSegmentBottom] autorelease];
    
    UIView * frontView = [self._frames objectAtIndex:_curentFrameIndex];
    [frontView setFrame:self.bounds];
    UIView * backView = 0;
    if(toIndex >=0 && toIndex < [_frames count])
    {
        backView = [self._frames objectAtIndex:toIndex];
    }
    else
    {
        backView = [[[UIView alloc] initWithFrame:self.bounds] autorelease];
        backView.backgroundColor = [UIColor grayColor];//使用灰色背景
    }
    [backView setFrame:self.bounds];
    
    UIImage *frontImage = [frontView image];
    UIImage *backImage = [backView image];
    
    // Images
    if (direction == CTFlipDirectionDown)
    {
        [self._topFaceLayer setContents:(id)backImage.CGImage];
        [self._bottomFaceLayer setContents:(id)frontImage.CGImage];
        [self._tickLayer._frontLayer setContents:(id)frontImage.CGImage];
        [self._tickLayer._backLayer setContents:(id)backImage.CGImage];
        
        [self._topFaceLayer set_gradientOpacity:1.];
        
        [self._tickLayer setTransform:CATransform3DIdentity];
    }
    else if (direction == CTFlipDirectionUp)
    {
        [self._topFaceLayer setContents:(__bridge id)frontImage.CGImage];
        [self._bottomFaceLayer setContents:(__bridge id)backImage.CGImage];
        [self._tickLayer._frontLayer setContents:(__bridge id)backImage.CGImage];
        [self._tickLayer._backLayer setContents:(__bridge id)frontImage.CGImage];
        
        [self._bottomFaceLayer set_gradientOpacity:1.];
        
        [self._tickLayer setTransform:CATransform3DMakeRotation(-M_PI, 1., 0., 0.)];
    }
    
    // Add layers
    [_flipLayer addSublayer:self._topFaceLayer];
    [_flipLayer addSublayer:self._bottomFaceLayer];
    [_flipLayer addSublayer:self._tickLayer];
}
-(void)rearrangeViewsAfterFlipToIndex:(int)toIndex direction:(CTFlipDirectionType)direction
{
    [_flipLayer removeFromSuperlayer], _flipLayer = nil;
    [self._topFaceLayer removeFromSuperlayer], self._topFaceLayer = nil;
    [self._bottomFaceLayer removeFromSuperlayer], self._bottomFaceLayer = nil;
    [self._tickLayer removeFromSuperlayer], self._tickLayer = nil;
    
    UIView * oldView = [self._frames objectAtIndex:_curentFrameIndex];
    [oldView removeFromSuperview];
    _curentFrameIndex = toIndex;
    int count = [_frames count];
    _curentFrameIndex = _curentFrameIndex <count ? _curentFrameIndex : count - 1;
    _curentFrameIndex = _curentFrameIndex >= 0 ? _curentFrameIndex : 0;
    UIView * newView = [self._frames objectAtIndex:_curentFrameIndex];
    [self addSubview:newView];
    
}
@end
