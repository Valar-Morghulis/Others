//
//  CTNetwork.h
//  BIPT_Base
//
//  Created by MaYing on 14-1-15.
//  Copyright (c) 2014年 Thinkfer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTWebService.h"
#import "CommonToolsDefine.h"
@class CTNetwork;
@protocol CTNetworkDelegate
-(void)beforeNetworkStart:(CTNetwork *)network;
-(BOOL)isResultVaild:(CTNetwork *)network data:(NSDictionary *)data;//判断数据合法性
-(void)networkStoped:(CTNetwork *)network success:(int)success;
-(void)afterNetworkStoped:(CTNetwork *)network;
@end

@interface CTNetwork : NSObject<CTWebServiceDelegate>
{
    NSDictionary * _data;
    CTWebService * _webService;
    id<CTNetworkDelegate> _delegate;
    NSString * _lastUrl;//最近的一个url路径
    int _netTag;//
}
@property(nonatomic,assign) id<CTNetworkDelegate> _delegate;
@property(nonatomic,readwrite) int _netTag;//
@property(nonatomic,retain) NSDictionary * _data;
@property(nonatomic,retain) CTWebService * _webService;
@property(nonatomic,retain) NSString * _lastUrl;//最近的一个url路径

-(void)httpRequestWithDIC:(NSDictionary *)dic;
-(void)httpRequestWithURL:(NSString *)url;
//
-(void)httpRequestWithPlatformDIC:(NSDictionary *)dic;//平台接口

-(NSString *)getPlatformSiginedUrl:(NSDictionary *)dic;
-(void)postWidthUrl:(NSString *)urlString data:(NSData *)postData;
-(void)cancel;
@end
