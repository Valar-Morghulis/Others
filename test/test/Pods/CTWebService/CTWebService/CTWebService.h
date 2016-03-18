//
//  CTWebService.h
//  testApp
//
//  Created by MaYing on 13-9-4.
//  Copyright (c) 2013年 MaYing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTURLConnectionOperation.h"

//for CTWebService
extern NSUInteger CTWebServiceRetries;//重复次数
extern NSUInteger CTWebServiceMaxConcurrentConnections ;//最大连接数
extern double CTWebServiceDefaultTimeOutInterval;//超时时间
extern NSString * CTWebServiceErrorDomain;//error domain
extern NSString * CTWebServiceHTTPResponseCodeKey;//
extern NSString * CTWebServiceNotificationErrorKey;//


enum
{
    CTWebServiceUnexpectedHTTPResponse,
    CTWebServiceZeroLengthResponse,
    CTWebServiceNotFoundResponse,
    CTWebServiceHTTPStatus500Error
};


@class CTWebService;

@protocol CTWebServiceDelegate
-(void)beforWebServiceStart:(CTWebService*)engine;
-(void)afterWebServiceEnd:(CTWebService*)engine;
@end
typedef enum LastExecutionResultEnum
{
    Result_None,
    Result_Canceld,
    Result_Error,
    Result_Succeed
}LastExecutionResult;

@interface CTWebService : NSObject

@property(nonatomic,assign)id<CTWebServiceDelegate> _serviceDelegate;
@property(nonatomic,readwrite)NSUInteger _retries;//重试次数
@property(nonatomic,retain,readonly)NSError *_lastError;//错误
@property(nonatomic,retain,readonly) NSMutableData *_cacheData;//
@property(nonatomic,retain,readonly) NSURL *_url;//url
@property(nonatomic,readonly)LastExecutionResult _lastExecutionResult;
@property(nonatomic,readonly)BOOL _resumeAndRetry;//标记

-(BOOL)isWorking;
- (void) cancelLoading;//取消加载
-(void)clearData;//清空数据
-(void)httpRequestWithURL:(NSString*)url;//get
-(void)postWidthUrl:(NSString *)urlString data:(NSData *)postData;//post

-(void)retry;//

-(NSDictionary *)backup;
-(void)resume:(NSDictionary *)dic;
-(void)resumeAndRetry:(NSDictionary *)dic;//自动循环所有的backup


+(void)pushBackup:(CTWebService *)service;
+(NSDictionary *)popBackup:(CTWebService *)service;
+(void)resumeAndRetry:(CTWebService *)service;
+(void)resumeAndRetryAll;//
+(void)cleanup:(CTWebService *)service;
+(void)cleanupAll;

@end
