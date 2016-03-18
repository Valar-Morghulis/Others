//
//  UINavigationController+CTNavigationBarBackgroundView.m
//  XY_Wallet
//
//  Created by yaoyongping on 13-10-12.
//
//

#import "UINavigationController+CTNavigationBarBackgroundView.h"
#import "CTDevice.h"
@implementation UINavigationController (CTNavigationBarBackgroundView)

-(UIView *)getNavigationBarBackgroundView
{
    UIView * res = 0;
    NSArray *subs=[self.navigationBar subviews];
    UIView *bgview = 0;
    for (UIView  *v in subs)
    {
        NSString *classname=NSStringFromClass([v class]);
        if ([classname isEqualToString:@"_UINavigationBarBackground"] || [classname isEqualToString:@"UINavigationBarBackground"])
        {
            bgview = v;
            break;
        }
    }
    
    if (bgview)
    {
        res = [bgview viewWithTag:NAVIGATIONCONTROLLER_BACKGROUNDVIEW_TAG];
    }
    return res;
}
-(void)setNavigationBarBackgroundView:(UIView *)backgroundView
{
    //self.navigationBar.backgroundColor = [UIColor redColor];
    NSArray *subs = [self.navigationBar subviews];
    UIView *bgview = 0;
    for (UIView  *v in subs)
    {
        NSString *classname=NSStringFromClass([v class]);
        if ([classname isEqualToString:@"_UINavigationBarBackground"] || [classname isEqualToString:@"UINavigationBarBackground"])
        {
            bgview = v;
            break;
        }
    }
    
    if (bgview)
    {
        UIView *v = [bgview viewWithTag:NAVIGATIONCONTROLLER_BACKGROUNDVIEW_TAG];
        if(v != backgroundView)
        {
            if(v)
            {
                [v removeFromSuperview];
            }
            [backgroundView setTag:NAVIGATIONCONTROLLER_BACKGROUNDVIEW_TAG];
            [bgview addSubview:backgroundView];
        }
    }
    CGRect frame = bgview.frame;
    frame.size.height = 44;
    if(IS_IOS7_OR_LATER)
    {
        frame.size.height += 20;
    }
    bgview.frame = frame;
    if(backgroundView)
    {
        [backgroundView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    }
}

@end
