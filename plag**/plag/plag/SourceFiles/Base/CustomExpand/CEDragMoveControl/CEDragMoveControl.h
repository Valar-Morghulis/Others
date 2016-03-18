//
//  CEDragMoveControl.h
//  test-4.5
//
//  Created by MaYing on 14-9-24.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CEDragMoveControl;
@protocol CEDragMoveControlDelegate
-(void)dragMoveBegin:(CEDragMoveControl *)control;//开始
-(void)dragMoving:(CEDragMoveControl *)control isChangeFrame:(BOOL)isChangeFrame;//移动中,isChangeFrame标志是否改变的frame
-(void)dragMoveStoped:(CEDragMoveControl *)control;//停止

-(void)beforeChangeAnimationStarted:(CEDragMoveControl *)control isChangeFrame:(BOOL)isChangeFrame;//
-(void)afterChangeAnimationStoped:(CEDragMoveControl *)control isChangeFrame:(BOOL)isChangeFrame;//
@end
@interface CEDragMoveControl : NSObject
{
    float _targetMinOriginY;////最小originY,对应最大的frame,移动过程中，左下角点位置不会改变,只以originY作为参考
    float _targetMaxOriginY;////最大originY,对应最小的frame
    CGRect _maxFrame;//最大范围
    CGRect _minFrame;//最小范围
    CGPoint _minContentOffset;
    CGPoint _maxContentOffset;
    
    BOOL _isInitArgs;//是否计算过参数
    
    UIPanGestureRecognizer * _panGestureRecognizer;
    CGPoint _startPoint;//pan的起点
    //
    //
    UIScrollView * _targetView;//目标View
    CGPoint _deltaOffset;//单位偏移量,x向左为负数，向右为正数，y向上为负数，向下为正数
    id<CEDragMoveControlDelegate> _delegate;
    
}
@property(nonatomic,retain) UIScrollView * _targetView;//
@property(nonatomic,readwrite) float _targetMinOriginY;
@property(nonatomic,readwrite) float _targetMaxOriginY;
@property(nonatomic,assign) id<CEDragMoveControlDelegate> _delegate;

//
@property(nonatomic,readonly) CGPoint _deltaOffset;//单位偏移量,x向左为负数，向右为正数，y向上为负数，向下为正数
@property(nonatomic,readonly) CGRect _maxFrame;//最大范围
@property(nonatomic,readonly) CGRect _minFrame;//最小范围
@property(nonatomic,readonly) CGPoint _minContentOffset;
@property(nonatomic,readonly) CGPoint _maxContentOffset;

//
-(void)initArgs;
-(void)tryChangeToNewFrame:(CGRect)newFrame animate:(BOOL)animate;//
-(void)tryChangeToNewContentOffset:(CGPoint)newContentOffset animate:(BOOL)animate;//
@end
