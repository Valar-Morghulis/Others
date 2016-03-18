//
//  GCNavBar.h
//  ProjectReports
//
//  Created by Thinkfer on 14/11/16.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GC_ConstantDefine.h"


@class GCNavBar;
@protocol GCNavBarDelegate
-(void)backButtonClicked:(GCNavBar *)bar;
-(void)rightButtonClicked:(GCNavBar *)bar;
@end
@interface GCNavBar : UIView
{
    UIButton * _backButton;
    UIButton * _rightButton;
    UILabel * _titleLabel;
    id<GCNavBarDelegate> _delegate;
}
@property(nonatomic,retain) UIButton * _rightButton;
@property(nonatomic,retain) UIButton * _backButton;
@property(nonatomic,retain) UILabel * _titleLabel;



@property(nonatomic,assign) id<GCNavBarDelegate> _delegate;

-(void)setTitleLabelText:(NSString *)title;
-(void)setBackButtonImage:(UIImage *) normalImage highlightImage:(UIImage *)highlightImage;
-(void)setRightButtonImage:(UIImage *) normalImage highlightImage:(UIImage *)highlightImage;//设置右键图片
@end
