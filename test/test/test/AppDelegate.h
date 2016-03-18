//
//  AppDelegate.h
//  test
//
//  Created by MaYing on 15/8/13.
//  Copyright (c) 2015年 xmg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYProgressHUD.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,MYProgressHUDDelegate>
{
    MYProgressHUD * _waitingView;
    int _waitingViewRefCount;//引用计数
}
@property(nonatomic,readwrite) BOOL isReadyForHandleNotification;
@property (strong, nonatomic) UIWindow *window;


@end

