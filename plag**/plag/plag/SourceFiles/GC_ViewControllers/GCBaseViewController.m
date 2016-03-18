//
//  GCBaseViewController.m
//  BIPT_Base
//
//  Created by Thinkfer on 14-1-16.
//  Copyright (c) 2014年 Thinkfer. All rights reserved.
//

#import "GCBaseViewController.h"


@implementation GCBaseViewController
@synthesize _navBar;
@synthesize _statusBar;

-(void)dealloc
{
    self._statusBar = 0;
    self._navBar = 0;
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    float height = DEVICE_SIZE.height;
    if(IS_IOS7_OR_LATER)
    {
        height += 20;
    }
    CGRect frame = CGRectMake(0, 0, DEVICE_SIZE.width, height);
    self.view.frame = frame;
 
#if 0
    float statusOriginX = 0;
    float statusOriginY = 0;
    float statusWidth = frame.size.width;
    float statusHeight = 0;
    if(IS_IOS7_OR_LATER)
    {
        statusHeight += 20;
    }
    self._statusBar = [[[UIView alloc] initWithFrame:CGRectMake(statusOriginX, statusOriginY, statusWidth, statusHeight)] autorelease];
    [self.view addSubview:self._statusBar];
    self._statusBar.backgroundColor = [UIColor blackColor];
    //
    float navBarOriginX = 0;
    float navBarWidth = frame.size.width;
    float navBarOriginY = 0;
    if(IS_IOS7_OR_LATER)
    {
        navBarOriginY += 20;
    }
    float navBarHeight = 44;
    self._navBar = [[[GCNavBar alloc] initWithFrame:CGRectMake(navBarOriginX, navBarOriginY, navBarWidth, navBarHeight)] autorelease];
    self._navBar._delegate = self;
    [self.view insertSubview:self._navBar atIndex:0];
    //
#endif
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //
    //默认不显示导航条
    [self hideNavigationBar:TRUE animate:FALSE];
  
}


#pragma mark CTNetworkDelegate
-(void)beforeNetworkStart:(CTNetwork *)network
{
    [self addWaitingView:TRUE];
}
-(BOOL)isResultVaild:(CTNetwork *)network data:(NSDictionary *)data
{
    BOOL res = TRUE;
    if(data)
    {
        int returnCode = [[data objectForKey:@"return_code"] intValue];

        if(returnCode != 0)
        {
            res = FALSE;
          
        }
        
    }
    return res;
}

-(void)showLogin
{
     [[NSNotificationCenter defaultCenter] postNotificationName:GCShowLoginPageKey object:0];
}
-(void)networkStoped:(CTNetwork *)network success:(int)success
{
    if(success == Result_Error)
    {
        NSString * errorTip = ErrorTip_Default;
        NSError * error = _network._webService._lastError;
        if(error)
        {
            if(error.code == CTWebServiceNotFoundResponse)
            {
                errorTip = ErrorTip_404;
            }
            else if(error.code == NSURLErrorTimedOut)
            {
                errorTip = ErrorTip_TimeOut;
            }
        }
        [CTUtility alertMessage:@"提示" message:errorTip];
    }
    
}

#pragma mark GCNavBarDelegate
-(void)backButtonClicked:(GCNavBar *)bar
{
    [self back:0];
}
-(void)rightButtonClicked:(GCNavBar *)bar{}

-(void)set_data:(NSDictionary *)data
{
    if(_data != data)
    {
        [data retain];
        [_data release];
        _data = data;
        [self parseData];
    }
}
-(void)parseData
{
    
}

@end
