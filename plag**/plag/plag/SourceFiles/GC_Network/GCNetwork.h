//
//  GCNetwork.h
//  ShoppingInLZ
//
//  Created by MaYing on 14-5-28.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import "CTNetwork.h"
#import "GCLoginManager.h"
typedef enum GCNetworkTag
{
    GCNetworkTag_CheckForUpdate = 100,//检查更新
    
    GCNetworkTag_GetConfig,//获取配置信息
    
    GCNetworkTag_LogIn,
    
}GCNetworkTag;

@interface CTNetwork(GCNetwork)

-(void)checkForUpdate;//检查更新

-(void)getConfig;//获取配置信息

-(void)logIn:(NSString *)userName pwd:(NSString *)pwd type:(int)type channelCode:(NSString *)channelCode;//登录


@end
