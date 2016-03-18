//
//  CEDragMoveControl.m
//  test-4.5
//
//  Created by MaYing on 14-9-24.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import "CEDragMoveControl.h"

@implementation CEDragMoveControl
@synthesize _delegate;
@synthesize _deltaOffset;
@synthesize _targetView;
@synthesize _targetMaxOriginY;
@synthesize _targetMinOriginY;
@synthesize _maxFrame;
@synthesize _minFrame;
@synthesize _maxContentOffset;
@synthesize _minContentOffset;

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
        _isInitArgs = FALSE;//
    }
}

-(void)initArgs
{
    _isInitArgs = TRUE;
    CGRect frame = self._targetView.frame;
    float disMaxY = frame.origin.y - self._targetMaxOriginY;//最小frame的跨度
    _minFrame = CGRectMake(frame.origin.x, self._targetMaxOriginY, frame.size.width, frame.size.height + disMaxY);
    float disMinY = frame.origin.y - self._targetMinOriginY;
    _maxFrame = CGRectMake(frame.origin.x, self._targetMinOriginY, frame.size.width, frame.size.height + disMinY);
    
    CGPoint minContentOffset = {0,0};
    _minContentOffset = minContentOffset;
    
    float maxOffsetY = self._targetView.contentSize.height - _maxFrame.size.height + 1;
    maxOffsetY = maxOffsetY > 0 ? maxOffsetY : 0;
    CGPoint maxContentOffset = {0,maxOffsetY};
    _maxContentOffset = maxContentOffset;
}
//
-(void)pan:(UIPanGestureRecognizer *)panGestureRecognizer
{
    if (_panGestureRecognizer.state == UIGestureRecognizerStateBegan)//开始
    {
        if(!_isInitArgs)
        {
            [self initArgs];//计算参数
        }
          _startPoint = [panGestureRecognizer locationInView:[UIApplication sharedApplication].keyWindow];//标记起点
        _deltaOffset = CGPointZero;//恢复为0
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
        
        BOOL changeFrame = [self tryChangeFrameOrContentOffsetAffterPan];
        //更新起点
        _startPoint = currentPostion;
        
        if(self._delegate)
        {
            [self._delegate dragMoving:self isChangeFrame:changeFrame];
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
-(BOOL)tryChangeFrameOrContentOffsetAffterPan
{
    BOOL changeFrame = FALSE;
    CGPoint contentOffset = self._targetView.contentOffset;
    CGRect frame = self._targetView.frame;
#if 1
    if(_deltaOffset.y < 0)//向上拖拽,优先考虑frame
    {
        if(frame.origin.y > _maxFrame.origin.y)//调整大小
        {
            changeFrame = TRUE;
        }

    }
    else//向下拖拽，优先考虑contentOffset
    {
        if(contentOffset.y <= 0)
        {
            changeFrame = TRUE;
        }
    }
#else  //old method
    BOOL changeFrame = FALSE;
    CGPoint contentOffset = self._targetView.contentOffset;
    CGRect frame = self._targetView.frame;
    if(frame.origin.y > _maxFrame.origin.y)//调整大小
    {
        changeFrame = TRUE;
    }
    else
    {
        changeFrame = FALSE;
        if(contentOffset.y <= 0 && _deltaOffset.y > 0)//调整大小
        {
            changeFrame = TRUE;
        }
    }
#endif
    if(changeFrame)
    {
        CGRect newFrame = frame;
        newFrame.origin.y += _deltaOffset.y;
        newFrame.size.height -= _deltaOffset.y;
        [self tryChangeToNewFrame:newFrame animate:FALSE];
    }
    else
    {
        CGPoint newContentOffset = contentOffset;
        newContentOffset.y += -_deltaOffset.y;
        [self tryChangeToNewContentOffset:newContentOffset animate:FALSE];
    }
    return changeFrame;
}

-(void)tryChangeToNewFrame:(CGRect)newFrame animate:(BOOL)animate
{
    //校准
    newFrame.origin.y = newFrame.origin.y < _maxFrame.origin.y ? _maxFrame.origin.y : newFrame.origin.y;
    newFrame.origin.y = newFrame.origin.y > _minFrame.origin.y ? _minFrame.origin.y : newFrame.origin.y;
    
    newFrame.size.height = newFrame.size.height > _maxFrame.size.height ? _maxFrame.size.height : newFrame.size.height;
    newFrame.size.height = newFrame.size.height < _minFrame.size.height ? _minFrame.size.height : newFrame.size.height;
    if(animate)
    {
        if(self._delegate)
        {
            [self._delegate beforeChangeAnimationStarted:self isChangeFrame:TRUE];
        }
        [UIView beginAnimations:@"changeFrame" context:nil];
        [UIView setAnimationDuration:1.0];
        self._targetView.frame = newFrame;
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(afterChangeFrameAnimationFinished)];
        [UIView commitAnimations];
    }
    else
    {
        self._targetView.frame = newFrame;
    }

}
-(void)tryChangeToNewContentOffset:(CGPoint)newContentOffset animate:(BOOL)animate
{
    //校准
    newContentOffset.y = newContentOffset.y > self._maxContentOffset.y ? self._maxContentOffset.y : newContentOffset.y;
    newContentOffset.y = newContentOffset.y < self._minContentOffset.y ? self._minContentOffset.y : newContentOffset.y;
    if(animate)
    {
        if(self._delegate)
        {
            [self._delegate beforeChangeAnimationStarted:self isChangeFrame:FALSE];
        }
        [UIView beginAnimations:@"changeFrame" context:nil];
        [UIView setAnimationDuration:1.0];
         [self._targetView setContentOffset:newContentOffset animated:FALSE];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(afterChangeContentOffsetAnimationFinished)];
        [UIView commitAnimations];
    }
    else
    {
         [self._targetView setContentOffset:newContentOffset animated:FALSE];
    }
}


-(void)afterChangeFrameAnimationFinished
{
    if(self._delegate)
    {
        [self._delegate afterChangeAnimationStoped:self isChangeFrame:TRUE];
    }
}
-(void)afterChangeContentOffsetAnimationFinished
{
    if(self._delegate)
    {
        [self._delegate afterChangeAnimationStoped:self isChangeFrame:FALSE];
    }
}
@end
