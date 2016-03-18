//
//  CTNavigationController.m
//  XY_Wallet
//
//  Created by yaoyongping on 13-10-12.
//
//

#import "CTNavigationController.h"

@interface CTNavigationController ()

@end

@implementation CTNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        UIImageView *navbg=[[UIImageView alloc] init];
        [navbg setImage:[UIImage imageNamed:CTNAVIGATIONCONTROLLER_BECKGROUNDIMAGE]];
        [self setNavigationBarBackgroundView: navbg];
        [navbg release];
    }
    return self;
}

-(id)initWithRootViewController:(UIViewController *)rootViewController{
    if (self=[super initWithRootViewController:rootViewController])
    {
        UIImageView *navbg=[[UIImageView alloc] init];
        [navbg setImage:[UIImage imageNamed:CTNAVIGATIONCONTROLLER_BECKGROUNDIMAGE]];
        [self setNavigationBarBackgroundView: navbg];
        [navbg release];
    }
    return self;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return FALSE;
}
-(BOOL)shouldAutorotate
{
    return FALSE;
}
-(NSInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
@end
