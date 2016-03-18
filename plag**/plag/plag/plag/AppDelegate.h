//
//  AppDelegate.h
//  BIPT_Base
//
//  Created by Thinkfer on 14-1-14.
//  Copyright (c) 2014年 Thinkfer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APP_GlobeDefine.h"
#import "CTDevice.h"
#import "GCMainViewController.h"
#import "CTNavigationController.h"
#import "MBProgressHUD.h"
#import "CommonToolsDefine.h"

#import "MLNavigationController.h"

#if USED_WECHAT
#import "WXApi.h"
#endif

@interface AppDelegate : UIResponder
<UIApplicationDelegate,
GCMapManagerDelegate

#if USED_WECHAT
,WXApiDelegate
#endif
>
{

    GCMapManager * _mapManager;
    
#if USED_WECHAT
    enum WXScene _scene;
#endif
    UIImageView * _startView;
    MBProgressHUD * _waitingView;
    GCMainViewController * _mainViewController;
    MLNavigationController * _navigationController;
    int _waitingViewRefCount;//引用计数
}
@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
//
- (void) sendTextContent:(NSString *)text;
- (void) sendLinkContent:(NSString *)title desc:(NSString *)desc thumbImg:(UIImage *)thumnImg url:(NSString *)url mediaTagName:(NSString *) mediaTagName;


@property(nonatomic,retain) GCMapManager * _mapManager;


@end
