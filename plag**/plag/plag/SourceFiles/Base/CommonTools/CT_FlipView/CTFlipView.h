//
//  CTFlipView.h
//  SBTickerViewDemo
//
//  Created by MaYing on 14-10-9.
//  Copyright (c) 2014年 Doubleint. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIView+CTFlipExtras.h"
#import "CTFlipDoubleSidedLayer.h"
#import "CTFlipGradientLayer.h"
#import "CTFlipAnimation.h"

@interface CTFlipView : UIView
{
    NSMutableArray * _frames;//
    int _curentFrameIndex;//
    
    //
    CTFlipGradientLayer * _topFaceLayer;
    CTFlipGradientLayer * _bottomFaceLayer;
    CALayer * _flipLayer;
    CTFlipDoubleSidedLayer * _tickLayer;//
    float _perspectiveDepth;
}
@property(nonatomic,retain) NSMutableArray * _frames;

@property(nonatomic,readonly) int _curentFrameIndex;//
@property(nonatomic,retain) CTFlipDoubleSidedLayer * _tickLayer;
@property(nonatomic,retain) CTFlipGradientLayer * _topFaceLayer;
@property(nonatomic,retain) CTFlipGradientLayer * _bottomFaceLayer;

@property(nonatomic,readwrite) float _perspectiveDepth;
-(void)insertFrameBeforeCurrentFrame:(UIView *)frame;
-(void)insertFrameAtLastIndex:(UIView *)frame;
-(void)addFrameView:(UIView *)frameView;
-(void)removeFrame:(UIView *)frame;
-(void)removeFrameAtIndex:(int)pageIndex;
-(int)count;//
-(void)clear;//
-(UIView *)currentFrame;
-(UIView *)upFrame;
-(UIView *)downFrame;

-(void)prepareFlipToIndex:(int)toIndex direction:(CTFlipDirectionType)direction;//
-(void)rearrangeViewsAfterFlipToIndex:(int)toIndex direction:(CTFlipDirectionType)direction;//
@end
