//
//  UINavigationController+CTNavigationBarBackgroundView.h
//  XY_Wallet
//
//  Created by yaoyongping on 13-10-12.
//
//

#import <UIKit/UIKit.h>
#import "APP_GlobeDefine.h"
#import "CommonToolsDefine.h"
@interface UINavigationController (CTNavigationBarBackgroundView)

-(UIView *)getNavigationBarBackgroundView;
-(void)setNavigationBarBackgroundView:(UIView *)backgroundView;

@end
