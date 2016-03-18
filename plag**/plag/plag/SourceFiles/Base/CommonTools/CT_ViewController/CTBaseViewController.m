//
//  CTBaseViewController.m
//  IHBaseProject
//
//  Created by yaoyongping on 13-1-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "CTBaseViewController.h"
#import "CTUtility.h"

@interface CTBaseViewController ()
@end

@implementation CTBaseViewController
-(void)dealloc
{
    NSLog(@"dealloc:%@", self);
    _network._delegate = 0;
    [_network cancel];
    [_network release];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CTNetworkCancleHTTPConnectionKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ( IS_IOS7_OR_LATER )
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
#endif
    float buttonHeight = 44;
    float buttonWidth = 44;
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, buttonHeight)];
	[leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
	[leftButton setImage:[UIImage imageNamed:DEFAULT_LEFTBUTTON_NORMAL_IMAGE] forState:UIControlStateNormal];
	[leftButton setImage:[UIImage imageNamed:DEFAULT_LEFTBUTTON_HIGHLIGHT_IMAGE] forState:UIControlStateHighlighted];
	[leftButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
	
	UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
	_leftButton = leftButton;
	[self.navigationItem setLeftBarButtonItem:leftButtonItem];
	[leftButton release];
	[leftButtonItem release];
	
	UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, buttonHeight)];
	[rightButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
	[rightButton setImage:[UIImage imageNamed:DEFAULT_RIGFHTBUTTON_NORMAL_IMAGE] forState:UIControlStateNormal];
	[rightButton setImage:[UIImage imageNamed:DEFAULT_RIGHTBUTTON_HIGHLIGHT_IMAGE] forState:UIControlStateHighlighted];
	[rightButton addTarget:self action:@selector(home:) forControlEvents:UIControlEventTouchUpInside];
	
	UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
	_rightButton = rightButton;
	[self.navigationItem setRightBarButtonItem:rightButtonItem];
	[rightButton release];
	[rightButtonItem release];
    

    _network = [[CTNetwork alloc] init];
    _network._delegate = self;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CancleHTTPConnectionNotification) name:CTNetworkCancleHTTPConnectionKey object:nil];

}
-(void)CancleHTTPConnectionNotification
{
    [_network cancel];
}
-(void)back:(id)sender
{
    [self popViewController:TRUE];
}
-(void)home:(id)sender
{
    [self popToRootController:TRUE];
}
-(void)setRightButtonImage:(UIImage *)img forState:(UIControlState)state
{
    [_rightButton setImage:img forState:state];
}
-(void)setLeftButtonImage:(UIImage *)img forState:(UIControlState)state
{
    [_leftButton setImage:img forState:state];
}

-(void)hideNavigationBar:(BOOL)hidden animate:(BOOL)animate
{
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:hidden],@"hidden",[NSNumber numberWithBool:animate],@"animate",nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:CTHideNavigationBarKey object:dic];
}
-(void)addWaitingView:(BOOL)canCancel
{
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:canCancel],@"canCancel",nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:CTAddWaitingViewKey object:dic];
}
-(void)removeWaitingView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:CTRemoveWaitingViewKey object:0];
}
-(void)pushViewController:(UIViewController *)viewController animate:(BOOL)animate
{
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:viewController,@"viewController",[NSNumber numberWithBool:animate],@"animate",nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:CTPushViewControllerKey object:dic];
}
-(void)popViewController:(BOOL)animate
{
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:animate],@"animate",nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:CTPopViewControllerKey object:dic];
}
-(void)popToRootController:(BOOL)animate
{
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:animate],@"animate",nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:CTPopToRootViewControllerKey object:dic];
}
-(void)openPresentModelViewController:(UIViewController *)viewController animate:(BOOL)animate
{
    [self openPresentModelViewController:viewController usedNav:FALSE animate:animate];
}
-(void)openPresentModelViewController:(UIViewController *)viewController usedNav:(BOOL) usedNav animate:(BOOL)animate
{
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:viewController,@"viewController",[NSNumber numberWithBool:usedNav],@"usedNav",[NSNumber numberWithBool:animate],@"animate",nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:CTOpenPresentModelViewControllerKey object:dic];
}
-(void)dismissModalViewController:(BOOL)animate
{
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:animate],@"animate",nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:CTDissmissModalViewContollerKey object:dic];
}

-(void)addStartView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:CTAddStartViewKey object:0];
}
-(void)removeStartView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:CTRemoveStartViewKey object:0];
}


#pragma mark CTNetworkDelegate
-(void)beforeNetworkStart:(CTNetwork *)network
{
    [self addWaitingView:FALSE];
}
-(BOOL)isResultVaild:(CTNetwork *)network data:(NSDictionary *)data
{
    return TRUE;
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
-(void)afterNetworkStoped:(CTNetwork *)network
{
    [self removeWaitingView];
}
@end


@implementation UIScrollView (BIPT)

-(CGRect)visibleRect{
    CGPoint p=self.contentOffset;
    CGRect rect=CGRectMake(p.x, p.y, self.frame.size.width, self.frame.size.height);
    return rect;
}

@end