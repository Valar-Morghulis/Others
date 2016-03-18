//
//  GCDragMoveHeaderAndFooter.h
//  plag
//
//  Created by MaYing on 15/6/2.
//  Copyright (c) 2015年 xiaofu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GC_ConstantDefine.h"
#import "APP_GlobeDefine.h"

@interface GCDragMoveBaseView : UIView

-(void)changeState;
-(void)recoverState;

@end

@interface GCDragMoveHeader : GCDragMoveBaseView
{
    UILabel * _label;
}
@property(nonatomic,retain) UILabel * _label;
@end

@interface GCDragMoveFooter : GCDragMoveBaseView
{
    UILabel * _label;
}
@property(nonatomic,retain) UILabel * _label;

@end