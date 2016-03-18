//
//  CTBaseViewController.h
//  IHBaseProject
//
//  Created by yaoyongping on 13-1-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTNetwork.h"
#import "CTDownImageView.h"
#import "CTUtility.h"
#import "CTDevice.h"
#import "APP_GlobeDefine.h"


@interface CTBaseViewController : UIViewController<CTNetworkDelegate>
{
    UIButton *_leftButton;
	UIButton *_rightButton;
    
    CTNetwork* _network;    
}
-(void)back:(id)sender;
-(void)home:(id)sender;
-(void)setRightButtonImage:(UIImage *)img forState:(UIControlState)state;
-(void)setLeftButtonImage:(UIImage *)img forState:(UIControlState)state;

-(void)hideNavigationBar:(BOOL)hidden animate:(BOOL)animate;
-(void)addWaitingView:(BOOL)canCancel;
-(void)removeWaitingView;
-(void)pushViewController:(UIViewController *)viewController animate:(BOOL)animate;
-(void)popViewController:(BOOL)animate;//
-(void)popToRootController:(BOOL)animate;//
-(void)openPresentModelViewController:(UIViewController *)viewController animate:(BOOL)animate;
-(void)openPresentModelViewController:(UIViewController *)viewController usedNav:(BOOL) usedNav animate:(BOOL)animate;
-(void)dismissModalViewController:(BOOL)animate;

-(void)addStartView;
-(void)removeStartView;

@end



@interface UIScrollView (BIPT)
-(CGRect)visibleRect;
@end