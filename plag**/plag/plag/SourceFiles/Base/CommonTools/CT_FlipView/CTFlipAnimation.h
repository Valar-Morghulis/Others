//
//  CTFlipAnimation.h
//  SBTickerViewDemo
//
//  Created by MaYing on 14-10-9.
//  Copyright (c) 2014年 Doubleint. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CTFlipView;

typedef enum
{
    CTFlipDirectionDown,
    CTFlipDirectionUp,
    CTFlipDirectionNone
} CTFlipDirectionType;

@class CTFlipAnimation;
@protocol CTFlipAnimationDelegate
-(void)beforeAnimationStart:(CTFlipAnimation *)animation direction:(CTFlipDirectionType)direction;
-(void)afterAnimationStoped:(CTFlipAnimation *)animation direction:(CTFlipDirectionType)direction;
-(void)canNotFlipAnyMore:(CTFlipAnimation *)animation direction:(CTFlipDirectionType)direction;

@end

@interface CTFlipAnimation : NSObject
{
    CTFlipDirectionType _direction;//
    id<CTFlipAnimationDelegate> _delegate;
    CTFlipView * _filpView;
    BOOL _isAnimating;//是否正在翻页
    float _duration;//
    //
    BOOL _enablePan;//
    UIPanGestureRecognizer * _panGesutrePrcognizer;//
    CGPoint _startPoint;//pan的起点
    CGPoint _deltaOffset;//单位偏移量,x向左为负数，向右为正数，y向上为负数，向下为正数
    int _newIndex;//
}
@property(nonatomic,readonly) CTFlipDirectionType _direction;
@property(nonatomic,readwrite) float _duration;//
@property(nonatomic,readwrite) BOOL _enablePan;//
@property(nonatomic,assign) id<CTFlipAnimationDelegate> _delegate;
@property(nonatomic,retain) CTFlipView * _filpView;

-(id)initWithDirection:(CTFlipDirectionType)direction flipView:(CTFlipView *)flipView delegate:(id<CTFlipAnimationDelegate>) delegate;
-(void)flipDown;
-(void)flipUp;
-(void)flipToIndex:(int)index animate:(BOOL)animate;//
@end
