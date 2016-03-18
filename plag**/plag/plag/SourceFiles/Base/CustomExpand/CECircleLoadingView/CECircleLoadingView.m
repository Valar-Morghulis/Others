//
//  CECircleLoadingView.m
//  HYCircleLoadingViewExample
//
//  Created by Shadow on 14-3-7.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CECircleLoadingView.h"

#define ANGLE(a) 2*M_PI/360*a

@interface CECircleLoadingView ()

//0.0 - 1.0
@property (nonatomic, assign) CGFloat _anglePer;

@property (nonatomic, retain) NSTimer *_timer;

@end

@implementation CECircleLoadingView
@synthesize _anglePer;
@synthesize _isAnimating;
@synthesize _lineColor;
@synthesize _lineWidth;
@synthesize _timer;

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)init
{
    if (self = [super init])
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
-(void)dealloc
{
    [self stopAnimation];
    self._timer = 0;
    self._lineColor = 0;
    [super dealloc];
}
- (void)set_anglePer:(CGFloat)anglePer
{
    _anglePer = anglePer;
    [self setNeedsDisplay];
}

- (void)startAnimation
{
    if (self._isAnimating)
    {
        [self stopAnimation];
        [self.layer removeAllAnimations];
    }
    _isAnimating = YES;
    
    self._anglePer = 0;
    self._timer = [NSTimer scheduledTimerWithTimeInterval:0.02f
                                                  target:self
                                                selector:@selector(drawPathAnimation:)
                                                userInfo:nil
                                                 repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self._timer forMode:NSRunLoopCommonModes];
}

- (void)stopAnimation
{
    _isAnimating = NO;
    
    if ([self._timer isValid])
    {
        [self._timer invalidate];
        self._timer = 0;
    }
    [self stopRotateAnimation];
}

- (void)drawPathAnimation:(NSTimer *)timer
{
    self._anglePer += 0.1f;
    
    if (self._anglePer >= 1) {
        self._anglePer = 1;
        [timer invalidate];
        self._timer = 0;
        [self startRotateAnimation];
    }
}

- (void)startRotateAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @(0);
    animation.toValue = @(2*M_PI);
    animation.duration = 1.f;
    animation.repeatCount = INT_MAX;
    
    [self.layer addAnimation:animation forKey:@"keyFrameAnimation"];
}

- (void)stopRotateAnimation
{
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self._anglePer = 0;
        [self.layer removeAllAnimations];
        self.alpha = 1;
    }];
}

- (void)drawRect:(CGRect)rect
{
    if (self._anglePer <= 0) {
        _anglePer = 0;
    }
    
    CGFloat lineWidth = 1.f;
    UIColor *lineColor = [UIColor lightGrayColor];
    if (self._lineWidth) {
        lineWidth = self._lineWidth;
    }
    if (self._lineColor) {
        lineColor = self._lineColor;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextAddArc(context,
                    CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds),
                    CGRectGetWidth(self.bounds)/2-lineWidth,
                    ANGLE(120), ANGLE(120)+ANGLE(330)*self._anglePer,
                    0);
    CGContextStrokePath(context);
}

@end
