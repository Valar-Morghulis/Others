//
//  CECircleLoadingView.h
//  HYCircleLoadingViewExample
//
//  Created by Shadow on 14-3-7.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CECircleLoadingView : UIView
{
    CGFloat _lineWidth;
    UIColor * _lineColor;
    BOOL _isAnimating;
    CGFloat _anglePer;
    NSTimer * _timer;
}
//default is 1.0f
@property (nonatomic, assign) CGFloat _lineWidth;

//default is [UIColor lightGrayColor]
@property (nonatomic, retain) UIColor *_lineColor;

@property (nonatomic, readonly) BOOL _isAnimating;

//use this to init
- (id)initWithFrame:(CGRect)frame;

- (void)startAnimation;
- (void)stopAnimation;//需要手动调用，否则内存释放有问题。

@end
