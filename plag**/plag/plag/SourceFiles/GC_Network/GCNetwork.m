//
//  GCNetwork.m
//  ShoppingInLZ
//
//  Created by MaYing on 14-5-28.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import "GCNetwork.h"

@implementation CTNetwork(GCNetwork)

-(void)checkForUpdate
{
    self._netTag = GCNetworkTag_CheckForUpdate;
    //
    [self httpRequestWithURL:@"http://fir.im/api/v2/app/version/5578eb419c082d576d00183a?token=7946ba00e28a11e48c1e0723187dbafc4ac79b88"];
}

-(void)getConfig
{
    self._netTag = GCNetworkTag_GetConfig;//
    NSDictionary * parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"GLGetC",@"method",
                                 nil];
    [self httpRequestWithDIC:parameters];
}
-(void)logIn:(NSString *)userName pwd:(NSString *)pwd type:(int)type channelCode:(NSString *)channelCode
{
    self._netTag = GCNetworkTag_LogIn;
    NSDictionary * parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"ih.euc.staff.auth",@"method",
                                 userName,@"authName",
                                 pwd,@"password",
                                 [NSNumber numberWithInt:type],@"type",
                                 channelCode,@"channelCode",
                                 nil];
    //[self httpRequestWithPlatformDIC:parameters];
    NSString * postStr = [self getPlatformSiginedUrl:parameters];
    NSData *data = [postStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString* url = [NSString stringWithFormat:@"%@",CTNETWORK_SERVER_URL];
    [self postWidthUrl:url data:data];
}
@end
