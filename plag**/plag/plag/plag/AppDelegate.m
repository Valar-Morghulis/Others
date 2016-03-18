//
//  AppDelegate.m
//  BIPT_Base
//
//  Created by Thinkfer on 14-1-14.
//  Copyright (c) 2014年 Thinkfer. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize _mapManager;

- (void)dealloc
{
    self._mapManager = 0;
    
    [_window release];
    [_managedObjectContext release];
    [_managedObjectModel release];
    [_persistentStoreCoordinator release];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CTAddWaitingViewKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CTRemoveWaitingViewKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CTWaitingViewTapRecognizerClickedKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CTAddStartViewKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CTRemoveStartViewKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if(_startView)
    {
        [_startView release];
    }
    if(_waitingView)
    {
        [_waitingView release];
    }
    [_mainViewController release];
    [_navigationController release];
    [super dealloc];
}

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    //
    _mainViewController = [[GCMainViewController alloc] init];
    _navigationController = [[MLNavigationController alloc] initWithRootViewController:_mainViewController];
    self.window.rootViewController = _navigationController;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addWaitingView:) name:CTAddWaitingViewKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(waitingViewTapRecognizerClicked) name:CTWaitingViewTapRecognizerClickedKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeWaitingView) name:CTRemoveWaitingViewKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addStartView) name:CTAddStartViewKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeStartView) name:CTRemoveStartViewKey object:nil];
    

    // 要使用百度地图，请先启动BaiduMapManager
    GCMapManager * mapManager = [[GCMapManager alloc]init];
    self._mapManager = mapManager;
    [mapManager release];
    
    BOOL ret = [self._mapManager start:MAP_KEY generalDelegate:self];
    if (!ret) {
        NSLog(@"mapManager start failed!");
    }

    
    
#if USED_WECHAT
    //向微信注册
    BOOL registed = [WXApi registerApp:WECHAT_AppID withDescription:@"XF_BusinessCard"];
    NSLog(@"微信注册%@",registed ? @"成功" : @"失败");
    _scene = WXSceneSession;//聊天界面
#endif
    
#if 0
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sensorStateChange:)
                                                 name:UIDeviceProximityStateDidChangeNotification
                                               object:nil];
    
#endif
    self.window.windowLevel = UIWindowLevelStatusBar + 1;
    [self.window makeKeyAndVisible];
    return YES;
}
#if 1
-(void)sensorStateChange:(NSNotificationCenter *)notification;
{
    if ([[UIDevice currentDevice] proximityState] == YES) {
        NSLog(@"Device is close to user");
        //在这里写上你要退出程序的代码即可，退出程序的方法不用我写了吧
    }else{
        NSLog(@"Device is not close to user");
    }
}
#endif
#if USED_WECHAT
- (void) sendTextContent:(NSString *)text
{
    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
    req.text = text;
    req.bText = YES;
    req.scene = _scene;
    
    [WXApi sendReq:req];
}

- (void) sendLinkContent:(NSString *)title desc:(NSString *)desc thumbImg:(UIImage *)thumnImg url:(NSString *)url mediaTagName:(NSString *) mediaTagName
{

    NSData *imageData = UIImageJPEGRepresentation(thumnImg, 0.01);
    thumnImg = [UIImage imageWithData:imageData];
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = desc;
    [message setThumbImage:thumnImg];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = url;
    
    message.mediaObject = ext;
    message.mediaTagName = mediaTagName;
    
    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
    req.bText = NO;
    req.message = message;
    req.scene = _scene;
    [WXApi sendReq:req];
}

- (void)sendAuthRequest
{
    SendAuthReq* req = [[[SendAuthReq alloc] init] autorelease];
    req.scope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact"; // @"post_timeline,sns"
    req.state = @"xxx";
    req.openID = @"0c806938e2413ce73eef92cc3";
    
    [WXApi sendAuthReq:req viewController:self.window.rootViewController delegate:self];
}

#endif



-(void)addStartView
{
    if(!_startView)
    {
        float originY = 20;
        float height = DEVICE_SIZE.height;
        if(IS_IOS7_OR_LATER)
        {
            originY = 0;
            height += 20;
        }
        _startView = [[UIImageView alloc] initWithFrame:CGRectMake(0, originY, 320, height)];
        _startView.image = [UIImage imageNamed:@"Default.png"];
    }
    [_startView removeFromSuperview];
    [self.window addSubview:_startView];
}

-(void)removeStartView
{
    if(_startView)
    {
        [_startView removeFromSuperview];
    }
}

-(void)addWaitingView:(NSNotification *)notification
{
    BOOL canCancel = FALSE;
    if(notification)
    {
        NSDictionary * dic = notification.object;
        if(dic)
        {
            canCancel = [[dic objectForKey:@"canCancel"] boolValue];
        }
    }
    //
    if(!_waitingView)
    {
        _waitingView = [[MBProgressHUD alloc] initWithFrame:self.window.frame];
        _waitingView.labelText = @"加载中...";
    }
    //_waitingView._canCancel = canCancel;
    if(_waitingViewRefCount <= 0)
    {
        [self.window addSubview:_waitingView];
        [_waitingView show:TRUE];
        _waitingViewRefCount = 0;
    }
    _waitingViewRefCount ++;
    
}
-(void)waitingViewTapRecognizerClicked
{
    //强制引用为0，强制移出
    _waitingViewRefCount = 0;
    [self removeWaitingView];
    //网络相关
    [[NSNotificationCenter defaultCenter] postNotificationName:CTNetworkCancleHTTPConnectionKey object:nil];
}
-(void)removeWaitingView
{
    _waitingViewRefCount--;
    if(_waitingViewRefCount <= 0)
    {
        if(_waitingView)
        {
            [_waitingView hide:TRUE];
            [_waitingView removeFromSuperview];
        }
        _waitingViewRefCount = 0;
    }
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    
#if USED_WECHAT
    return  [WXApi handleOpenURL:url delegate:self];
#endif
    return FALSE;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
#if USED_WECHAT
    return  [WXApi handleOpenURL:url delegate:self];
#endif
    return FALSE;
}

//
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"BIPT_Base" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"BIPT_Base.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark WXApiDelegate
#if USED_WECHAT
-(void) onReq:(BaseReq*)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        GetMessageFromWXReq *temp = (GetMessageFromWXReq *)req;
        
        // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
        NSString *strMsg = [NSString stringWithFormat:@"openID: %@", temp.openID];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 1000;
        [alert show];
        [alert release];
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        WXMediaMessage *msg = temp.message;
        
        //显示微信传过来的内容
        WXAppExtendObject *obj = msg.mediaObject;
        
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
        NSString *strMsg = [NSString stringWithFormat:@"openID: %@, 标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%u bytes\n附加消息:%@\n", temp.openID, msg.title, msg.description, obj.extInfo, msg.thumbData.length, msg.messageExt];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else if([req isKindOfClass:[LaunchFromWXReq class]])
    {
        LaunchFromWXReq *temp = (LaunchFromWXReq *)req;
        WXMediaMessage *msg = temp.message;
        
        //从微信启动App
        NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
        NSString *strMsg = [NSString stringWithFormat:@"openID: %@, messageExt:%@", temp.openID, msg.messageExt];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}

-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        NSLog(@"%@",strMsg);
    }
    else if([resp isKindOfClass:[SendAuthResp class]])
    {
        SendAuthResp *temp = (SendAuthResp*)resp;
        
        NSString *strTitle = [NSString stringWithFormat:@"Auth结果"];
        NSString *strMsg = [NSString stringWithFormat:@"code:%@,state:%@,errcode:%d", temp.code, temp.state, temp.errCode];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else if ([resp isKindOfClass:[AddCardToWXCardPackageResp class]])
    {
        AddCardToWXCardPackageResp* temp = (AddCardToWXCardPackageResp*)resp;
        NSMutableString* cardStr = [[[NSMutableString alloc] init] autorelease];
        for (WXCardItem* cardItem in temp.cardAry) {
            [cardStr appendString:[NSString stringWithFormat:@"cardid:%@ cardext:%@ cardstate:%lu\n",cardItem.cardId,cardItem.extMsg,cardItem.cardState]];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"add card resp" message:cardStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}

#endif


#pragma mark GCMapManagerDelegate

- (void)onGetNetworkState:(int)iError
{
    
}

- (void)onGetPermissionState:(int)iError
{
    
}

@end
