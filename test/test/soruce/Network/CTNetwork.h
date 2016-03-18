//
//  CTNetwork.h
//  BIPT_Base
//
//  Created by MaYing on 14-1-15.
//  Copyright (c) 2014年 Thinkfer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTWebService.h"
#import "APP_GlobeDefine.h"

@class CTNetwork;
@protocol CTNetworkDelegate
-(void)beforeNetworkStart:(CTNetwork *)network;
-(BOOL)isResultVaild:(CTNetwork *)network data:(NSDictionary *)data;//判断数据合法性
-(void)networkStoped:(CTNetwork *)network success:(int)success;
-(void)afterNetworkStoped:(CTNetwork *)network;
@end

@interface CTNetwork : CTWebService<CTWebServiceDelegate>

@property(nonatomic,assign) id<CTNetworkDelegate> _delegate;
@property(nonatomic,readwrite) int _netTag;//
@property(nonatomic,retain,readonly) NSDictionary * _data;

//get
-(void)httpRequestWithDIC:(NSDictionary *)dic;
-(void)httpRequestWithPlatformDIC:(NSDictionary *)dic;//平台接口


+(NSString *)getPlatformSiginedUrl:(NSDictionary *)dic;
+(NSString *)getParameterString:(NSDictionary *)dic;

@end
