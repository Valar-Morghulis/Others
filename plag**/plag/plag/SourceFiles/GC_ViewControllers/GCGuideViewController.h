//
//  GCGuideViewController.h
//  GuangCity
//
//  Created by MaYing on 14-10-23.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import "CEGuideViewController.h"
#import "CEPageControl.h"

@class GCGuideViewController;
@protocol GCGuideViewControllerDelegate <CEGuideViewControllerDelegate>
-(void)loginButtonClicked:(GCGuideViewController *)controller;
-(void)registButtonClicked:(GCGuideViewController *)controller;
@end
@interface GCGuideViewController : CEGuideViewController
{
    CEPageControl *_pageControl;
    UIView * _buttonContainer;
    CGRect _buttonContainerOriginFrame;
    UIImageView * _headImageView;
    CGRect _headImageOriginFrame;
}
@property(nonatomic,assign) id<GCGuideViewControllerDelegate> _delegate;

@end
