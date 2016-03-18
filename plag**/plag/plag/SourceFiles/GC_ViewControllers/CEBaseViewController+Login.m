//
//  CEBaseViewController+Login.m
//  GuangCity
//
//  Created by MaYing on 14-10-23.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import "CEBaseViewController+Login.h"
#import "GCLoginManager.h"
@implementation CEBaseViewController(login)

-(BOOL)showLoginPageWidthDelegate:(id)delegate;//登陆
{
    BOOL res = ![GCLoginManager instance]._isLogin;
    if(res)
    {
        NSDictionary * dic = 0;
        if(delegate)
        {
            dic = [NSDictionary dictionaryWithObjectsAndKeys:delegate,@"delegate",nil];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:GCShowLoginPageKey object:dic];
    }
    return res;
}
@end
