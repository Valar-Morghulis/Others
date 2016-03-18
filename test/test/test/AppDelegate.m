//
//  AppDelegate.m
//  test
//
//  Created by MaYing on 15/8/13.
//  Copyright (c) 2015年 xmg. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MainViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CTAddWaitingViewKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CTRemoveWaitingViewKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //
    if(_waitingView)
    {
        [_waitingView release];
    }
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addWaitingView:) name:CTAddWaitingViewKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeWaitingView) name:CTRemoveWaitingViewKey object:nil];
    
    self.window = [[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
        self.window.rootViewController = [[[UINavigationController alloc] initWithRootViewController:[[[MainViewController alloc] init] autorelease]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void)addWaitingView:(NSNotification *)notification
{
    
    BOOL canCancel = FALSE;
    NSString * tips = 0;
    if(notification)
    {
        NSDictionary * dic = notification.object;
        if(dic)
        {
            canCancel = [[dic objectForKey:@"canCancel"] boolValue];
            tips = [dic objectForKey:@"tips"];
        }
    }
    if(!tips) tips = @"Loading...";    //
    if(!_waitingView)
    {
        _waitingView = [[MYProgressHUD alloc] initWithFrame:self.window.frame];
        _waitingView.delegate = self;
    }
    _waitingView.labelText = tips;
    _waitingView._canCancel = canCancel;
    if(_waitingViewRefCount <= 0)
    {
        [self.window addSubview:_waitingView];
        [_waitingView show:TRUE];
        _waitingViewRefCount = 0;
    }
    _waitingViewRefCount ++;
    
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
#pragma mark MYProgressHUDDelegate
-(void)hudWasTaped:(MYProgressHUD *)hud
{
    //强制引用为0，强制移出
    _waitingViewRefCount = 0;
    [self removeWaitingView];
}

@end
