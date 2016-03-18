//
//  GCMainViewController.m
//  BIPT_Base
//
//  Created by Thinkfer on 14-1-16.
//  Copyright (c) 2014年 Thinkfer. All rights reserved.
//

#import "GCMainViewController.h"
#import "CTNavigationController.h"
#import "GCDataManager.h"
#import "CTDevice.h"
#import "GCLoginViewController.h"
#import "GCLoginManager.h"

NSString * CTIMG_BASEURL = @"";//图片基础路径

@implementation GCMainViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CTPushViewControllerKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CTPopViewControllerKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CTPopToRootViewControllerKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CTOpenPresentModelViewControllerKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CTDissmissModalViewContollerKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CTHideNavigationBarKey object:nil];
   [[NSNotificationCenter defaultCenter] removeObserver:self name:GCShowLoginPageKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_homeViewController release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doPushViewController:) name:CTPushViewControllerKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doPopViewController:) name:CTPopViewControllerKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doPopToRootController:) name:CTPopToRootViewControllerKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doOpenPresentModelViewController:) name:CTOpenPresentModelViewControllerKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doDissmissModalViewContoller:) name:CTDissmissModalViewContollerKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doHideNavigationBar:) name:CTHideNavigationBarKey object:nil];
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doShowLoginPage) name:GCShowLoginPageKey object:nil];

    
    //设置状态栏文字颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self addStartView];
    [self._navBar removeFromSuperview];
    self._navBar= 0;
//
#if USED_CHECK_UPDATE
    [_network checkForUpdate];
#else
    [self loadHome];
#endif
    

}


-(void)loadHome
{
    [self removeStartView];//移除启动页
    if (![self addGuideControllerFirst] && [self loginSecond])
    {
        [self initHomeViewController];
    }
}
-(BOOL)loginSecond
{
    return true;
    
    
    BOOL res = [GCLoginManager instance]._isLogin;
    if(!res)
    {
        GCLoginViewController * controller = [[GCLoginViewController alloc] init];
        controller._delegate = self;
        [self openPresentModelViewController:controller usedNav:TRUE animate:TRUE];
        [controller release];
    }
    return res;
}
-(void)initHomeViewController
{
    if(_homeViewController)
    {
        [self popToRootController:TRUE];
    }
    else
    {
        _homeViewController = [[GCHomeViewController alloc] init];
        [self pushViewController:_homeViewController animate:FALSE];
    }
    
    [_homeViewController refresh];
}


-(void)checkForUpdateNewVersion//版本检测
{
    NSString * versionNow = [[GCDataManager instance]._configData objectForKey:@"version"];
    if([versionNow compare:APP_VERSION_STRING] == NSOrderedDescending)
    {
        //提示下载新版本
        [CTUtility alertMessage:@"提示" message:@"检测到新版本，是否现在更新？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新" tag:1025];
    }
    else
    {
        [self loadHome];
    }
}
#pragma mark 网络
-(void)beforeNetworkStart:(CTNetwork *)network
{
    //[self addWaitingView:FALSE];
}

-(void)networkStoped:(CTNetwork *)network success:(int)success
{
    if(success == Result_Succeed)
    {
        if(network._netTag == GCNetworkTag_CheckForUpdate)
        {
            [GCDataManager instance]._configData = network._data;
            [self checkForUpdateNewVersion];
        }
    }
    else
    {
        [self loadHome];
    }
}


#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1025)//版本更新
    {
        if(buttonIndex == 1)
        {
            NSString * downloadAppUrl =  [[GCDataManager instance]._configData objectForKey:@"update_url"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:downloadAppUrl]];
            exit(0);
        }
        else
        {
            [self loadHome];
        }

    }
}

-(BOOL)addGuideControllerFirst
{
    BOOL added = FALSE;
    //显示引导页面,如果需要的话
    CEGuideViewController * guideViewController = [[GCGuideViewController alloc] init];
    [guideViewController initlizeWithKey:@"isGuideUsed"];
    guideViewController._delegate = self;
    if(!guideViewController._isGuideUsedBefore)
    {
        [self pushViewController:guideViewController animate:FALSE];
        
        added = TRUE;
    }
    [guideViewController release];
    return added;
}

#pragma mark GCGuideViewControllerDelegate
-(void)guideFinished:(CEGuideViewController *)controller
{
    if([self loginSecond])
        [self initHomeViewController];
}
-(void)loginButtonClicked:(GCGuideViewController *)controller
{
    if([self loginSecond])
        [self initHomeViewController];
}

-(void)registButtonClicked:(GCGuideViewController *)controller
{
    if([self loginSecond])
        [self initHomeViewController];
}
#pragma mark GCLoginViewControllerDelegate
-(void)loginSuccess:(GCLoginViewController *)controller
{
    [self dismissModalViewController:TRUE];//弹出登录
    [self initHomeViewController];
}
//
#pragma mark NSNotifications
-(void)doShowLoginPage
{
    [self popToRootController:FALSE];
    GCLoginViewController * controller = [[GCLoginViewController alloc] init];
    controller._delegate = self;
    
    [self openPresentModelViewController:controller usedNav:TRUE animate:TRUE];
    
    [controller release];
    
}
-(void)doPushViewController:(NSNotification *)notification
{
    UIViewController * viewController = 0;
    BOOL animate = FALSE;
    if(notification)
    {
        NSDictionary *dic = [notification object];
        if(dic)
        {
            viewController = [dic objectForKey:@"viewController"];
            animate = [[dic objectForKey:@"animate"] boolValue];
        }
    }
    if(viewController)
    {
        [self.navigationController pushViewController:viewController animated:animate];
    }
}
-(void)doPopViewController:(NSNotification *)notification
{
    BOOL animate = FALSE;
    if(notification)
    {
        NSDictionary *dic = [notification object];
        if(dic)
        {
            animate = [[dic objectForKey:@"animate"] boolValue];
        }
    }
    [self.navigationController popViewControllerAnimated:animate];
}
-(void)doPopToRootController:(NSNotification *)notification
{
    BOOL animate = FALSE;
    if(notification)
    {
        NSDictionary *dic = [notification object];
        if(dic)
        {
            animate = [[dic objectForKey:@"animate"] boolValue];
        }
    }
    [self.navigationController popToViewController:_homeViewController animated:animate];
}
-(void)doOpenPresentModelViewController:(NSNotification *)notification
{
    UIViewController * viewController = 0;
    BOOL animate = FALSE;
    BOOL usedNav = FALSE;
    if(notification)
    {
        NSDictionary *dic = [notification object];
        if(dic)
        {
            viewController = [dic objectForKey:@"viewController"];
            animate = [[dic objectForKey:@"animate"] boolValue];
            usedNav = [[dic objectForKey:@"usedNav"] boolValue];
        }
    }
    if(viewController)
    {
        if(usedNav)
        {
            CTNavigationController * navController = [[CTNavigationController alloc] initWithRootViewController:viewController];
            [self.navigationController presentModalViewController:navController animated:animate];
            [navController release];
        }
        else
        {
            [self.navigationController presentModalViewController:viewController animated:animate];
        }
    }
}

-(void)doDissmissModalViewContoller:(NSNotification *)notification
{
    BOOL animate = FALSE;
    if(notification)
    {
        NSDictionary *dic = [notification object];
        if(dic)
        {
            NSDictionary * dic = notification.object;
            animate = [[dic objectForKey:@"animate"] boolValue];
        }
    }
    [self.navigationController dismissModalViewControllerAnimated:animate];
}
-(void)doHideNavigationBar:(NSNotification *)notification
{
    BOOL hidden = FALSE;
    BOOL animate = FALSE;
    if(notification)
    {
        NSDictionary *dic = [notification object];
        if(dic)
        {
            hidden = [[dic objectForKey:@"hidden"] boolValue];
            animate = [[dic objectForKey:@"animate"] boolValue];
        }
    }
    [self.navigationController setNavigationBarHidden:hidden animated:animate];
}
@end
