//
//  GCLoginViewController.h
//  GuangCity
//
//  Created by MaYing on 14-10-23.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import "GCBaseViewController.h"


@class GCLoginViewController;

@protocol GCLoginViewControllerDelegate
-(void)loginSuccess:(GCLoginViewController *)controller;
@end

@interface GCLoginViewController : GCBaseViewController<UITextFieldDelegate,UIAlertViewDelegate>
{
    UITextField * _userName;
    UITextField * _pwd;
    id<GCLoginViewControllerDelegate> _delegate;
  }
@property(nonatomic,assign) id<GCLoginViewControllerDelegate> _delegate;



@end
