//
//  GCDragMoveControl.h
//  plag
//
//  Created by MaYing on 15/6/1.
//  Copyright (c) 2015年 xiaofu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GCDragMoveControl;
@protocol GCDragMoveControlDelegate
-(void)dragMoveBegin:(GCDragMoveControl *)control;//开始
-(void)dragMoving:(GCDragMoveControl *)control deltaOffset:(CGPoint)deltaOffset;//移动中
-(void)dragMoveStoped:(GCDragMoveControl *)control;//停止


@end


@interface GCDragMoveControl : NSObject
{
    UIPanGestureRecognizer * _panGestureRecognizer;
    CGPoint _startPoint;//pan的起点
    
    UIView * _targetView;//目标View
    CGPoint _deltaOffset;//单位偏移量,x向左为负数，向右为正数，y向上为负数，向下为正数
    id<GCDragMoveControlDelegate> _delegate;
    CGPoint _offset;//偏移量,x向左为负数，向右为正数，y向上为负数，向下为正数
}

@property(nonatomic,retain) UIView * _targetView;//
@property(nonatomic,assign) id<GCDragMoveControlDelegate> _delegate;
@property(nonatomic,readonly) CGPoint _offset;//偏移量,x向左为负数，向右为正数，y向上为负数，向下为正数

@end
