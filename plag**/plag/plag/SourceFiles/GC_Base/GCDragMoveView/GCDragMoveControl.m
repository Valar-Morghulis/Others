//
//  GCDragMoveControl.m
//  plag
//
//  Created by MaYing on 15/6/1.
//  Copyright (c) 2015年 xiaofu. All rights reserved.
//

#import "GCDragMoveControl.h"

@implementation GCDragMoveControl
@synthesize _delegate;
@synthesize _offset;
@synthesize _targetView;

-(id)init
{
    if(self = [super init])
    {
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    }
    return self;
}
-(void)dealloc
{
    self._targetView = 0;
    [_panGestureRecognizer release];
    [super dealloc];
}

-(void)set_targetView:(UIScrollView *)targetView
{
    if(_targetView != targetView)
    {
        if(_targetView)
        {
            [_targetView removeGestureRecognizer:_panGestureRecognizer];
            [_targetView release];
        }
        _targetView = targetView;
        if(_targetView)
        {
            [_targetView addGestureRecognizer:_panGestureRecognizer];
            [_targetView retain];
        }
    }
}

-(void)pan:(UIPanGestureRecognizer *)panGestureRecognizer
{
    if (_panGestureRecognizer.state == UIGestureRecognizerStateBegan)//开始
    {
        _startPoint = [panGestureRecognizer locationInView:[UIApplication sharedApplication].keyWindow];//标记起点
        _deltaOffset = CGPointZero;//恢复为0
        _offset = CGPointZero;
        
        if(self._delegate)
        {
            [self._delegate dragMoveBegin:self];//
        }
    }
    else if (_panGestureRecognizer.state == UIGestureRecognizerStateChanged)//移动中
    {
        //计算偏移量
        CGPoint currentPostion = [panGestureRecognizer locationInView:[UIApplication sharedApplication].keyWindow];
        _deltaOffset.x  =  -_startPoint.x + currentPostion.x ;
        _deltaOffset.y  =  -_startPoint.y + currentPostion.y ;
        
        _offset.x += _deltaOffset.x;
        _offset.y += _deltaOffset.y;
        
        //更新起点
        _startPoint = currentPostion;
        
        CGRect newFrame = self._targetView.frame;
        newFrame.origin.y += _deltaOffset.y;
        self._targetView.frame = newFrame;
       
        if(self._delegate)
        {
            [self._delegate dragMoving:self deltaOffset:_deltaOffset];
        }
    }
    else if (_panGestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        if(self._delegate)
        {
            [self._delegate dragMoveStoped:self];
        }
    }
}

@end
