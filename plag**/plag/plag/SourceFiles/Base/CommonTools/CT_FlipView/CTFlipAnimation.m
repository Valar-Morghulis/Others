//
//  CTFlipAnimation.m
//  SBTickerViewDemo
//
//  Created by MaYing on 14-10-9.
//  Copyright (c) 2014年 Doubleint. All rights reserved.
//

#import "CTFlipAnimation.h"
#import "CTFlipView.h"

@implementation CTFlipAnimation
@synthesize _delegate;
@synthesize _direction;
@synthesize _enablePan;
@synthesize _filpView;
@synthesize _duration;

-(void)dealloc
{
    self._filpView = 0;
    if(_panGesutrePrcognizer)
    {
        [_panGesutrePrcognizer release];
    }
    [super dealloc];
}
-(id)initWithDirection:(CTFlipDirectionType)direction flipView:(CTFlipView *)flipView delegate:(id<CTFlipAnimationDelegate>)delegate
{
    if(self = [super init])
    {
        _direction = direction;
        self._filpView = flipView;
        self._delegate = delegate;
        _duration = 0.5;
    }
    return self;
}
-(void)set_enablePan:(BOOL)enablePan
{
    if(_enablePan != enablePan)
    {
        _enablePan = enablePan;
        if(_enablePan)
        {
            if(!_panGesutrePrcognizer)
            {
                _panGesutrePrcognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
            }
            [self._filpView addGestureRecognizer:_panGesutrePrcognizer];
        }
        else
        {
            [self._filpView removeGestureRecognizer:_panGesutrePrcognizer];
        }
    }
}

-(void)flipDown
{
    [self flipToIndex:self._filpView._curentFrameIndex-1 animate:TRUE];
}
-(void)flipUp
{
    [self flipToIndex:self._filpView._curentFrameIndex+1 animate:TRUE];
}
-(void)afterAnimationDone
{
    _isAnimating = FALSE;
    [self._filpView rearrangeViewsAfterFlipToIndex:_newIndex direction:self._direction];
    if(self._delegate)
    {
        [self._delegate afterAnimationStoped:self direction:self._direction];
    }
}
-(void)flipToIndex:(int)index animate:(BOOL)animate
{
    if(_isAnimating)
    {
        return;
    }
    int currentIndex = self._filpView._curentFrameIndex;
    int maxCount = (int)[self._filpView._frames count];
    int minCount = 0;
    void(^block)(void) = ^(void){
        [self afterAnimationDone];};
    float angle = 0;
    float topOpacity = 0;
    float bottomOpacity = 0;
    float frontOpacity = 0;
    float backOpacity = 0;
    float duration = self._duration;
    if(currentIndex == index)
    {
        _direction = CTFlipDirectionNone;
    }
    else if(currentIndex > index)
    {
        _direction = CTFlipDirectionDown;
        angle = M_PI;
        topOpacity = 0;
        bottomOpacity = 1;
        frontOpacity = 1;
        backOpacity = 0;
        if(index < minCount)
        {
            if(self._delegate)
            {
                [self._delegate canNotFlipAnyMore:self direction:_direction];
            }
            angle = M_PI  / -4.0;
            topOpacity = 0;
            bottomOpacity = 0.5;
            frontOpacity = 0.5;
            backOpacity = 0;
             animate = TRUE;
            duration /= 2.0;
            block = ^(void){
                float newAngle = 0;
                float newTopOpacity = 0.5;
                float newBottomOpacity = 0;
                float newFrontOpacity = 0;
                float newBackOpacity = 0.5;
                BOOL newAnimate = TRUE;
                [self doFlip:newAngle topOpacity:newTopOpacity bottomOpacity:newBottomOpacity frontOpacity:newFrontOpacity backOpacity:newBackOpacity animate:newAnimate duration:duration bolck:^(void){
                [self afterAnimationDone];}];
                };
        }
    }
    else
    {
        _direction = CTFlipDirectionUp;
        angle = 0;
        topOpacity = 1;
        bottomOpacity = 0;
        frontOpacity = 0;
        backOpacity = 1;
        if(index >= maxCount)
        {
            if(self._delegate)
            {
                [self._delegate canNotFlipAnyMore:self direction:_direction];
            }
            angle = M_PI + M_PI / 4.0 ;
            topOpacity = 0.5;
            bottomOpacity = 0;
            frontOpacity = 0;
            backOpacity = 0.5;
            animate = TRUE;
            duration /= 2.0;
            block = ^(void){
                float newAngle = M_PI;
                float newTopOpacity = 0;
                float newBottomOpacity = 0.5;
                float newFrontOpacity = 0.5;
                float newBackOpacity = 0;
                BOOL newAnimate = TRUE;
                [self doFlip:newAngle topOpacity:newTopOpacity bottomOpacity:newBottomOpacity frontOpacity:newFrontOpacity backOpacity:newBackOpacity animate:newAnimate duration:duration bolck:^(void){
                    [self afterAnimationDone];}];
            };

        }
    }
    _isAnimating = TRUE;
    _newIndex = index;
    if(self._delegate)
    {
        [self._delegate beforeAnimationStart:self direction:self._direction];
    }
    [self._filpView prepareFlipToIndex:_newIndex direction:self._direction];
    //
    [self doFlip:angle topOpacity:topOpacity bottomOpacity:bottomOpacity frontOpacity:frontOpacity backOpacity:backOpacity animate:animate duration:duration bolck:block];
}
-(void)doFlip:(float)angle topOpacity:(float) topOpacity bottomOpacity:(float)bottomOpacity frontOpacity:(float) frontOpacity backOpacity:(float)backOpacity  animate:(BOOL)animate duration:(float)duration bolck:(void (^)(void))block
{
    if(animate)
    {
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, .01 * NSEC_PER_SEC); // WTF!
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [CATransaction begin];
            [CATransaction setAnimationDuration:duration];
            
            [CATransaction setCompletionBlock:block];
            self._filpView._tickLayer.transform = CATransform3DMakeRotation(angle, 1., 0., 0.);
            self._filpView._topFaceLayer._gradientOpacity = topOpacity;
            self._filpView._bottomFaceLayer._gradientOpacity = bottomOpacity;
            
            ((CTFlipGradientLayer*)self._filpView._tickLayer._frontLayer)._gradientOpacity = frontOpacity;
            ((CTFlipGradientLayer*)self._filpView._tickLayer._backLayer)._gradientOpacity = backOpacity;
            [CATransaction commit];
        });
    }
    else
    {
        [self afterAnimationDone];
    }
}

-(void)pan:(UIPanGestureRecognizer *)gesture
{
    if(self._enablePan)
    {
        if (gesture.state == UIGestureRecognizerStateBegan)//开始
        {
            _startPoint = [gesture locationInView:[UIApplication sharedApplication].keyWindow];//标记起点
            _deltaOffset = CGPointZero;//恢复为0
        }
        else if (gesture.state == UIGestureRecognizerStateChanged)//移动中
        {
            
        }
        else if (gesture.state == UIGestureRecognizerStateEnded)
        {
            CGPoint currentPostion = [gesture locationInView:[UIApplication sharedApplication].keyWindow];
            _deltaOffset.x  =  -_startPoint.x + currentPostion.x ;
            _deltaOffset.y  =  -_startPoint.y + currentPostion.y ;
            
            if(fabsf(_deltaOffset.y) > fabsf(_deltaOffset.x))//
            {
                //判断方向
                if(_deltaOffset.y > 0)
                {
                    [self flipDown];
                }
                else
                {
                    [self flipUp];
                }
            }
        }
    }
}
@end
