//
//  BaseViewController.h
//  test
//
//  Created by smallpay on 16/1/26.
//  Copyright © 2016年 xmg. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CTAddWaitingViewKey                              @"CTAddWaitingView"//加载中..
#define CTRemoveWaitingViewKey                        @"CTRemoveWaitingView"

@interface BaseViewController : UIViewController
-(void)addWaitingView:(BOOL)canCancel;
-(void)removeWaitingView;
@end
