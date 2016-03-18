//
//  CTWebService.h
//  testApp
//
//  Created by MaYing on 13-9-4.
//  Copyright (c) 2013年 MaYing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTURLConnectionOperation.h"
#import "APP_GlobeDefine.h"
#import "CustomExpandDefine.h"
#import "CommonToolsDefine.h"
enum {
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
{
    int _serviceTag;
    id<CTWebServiceDelegate> _delegate;
    
    NSUInteger _retries;//重试次数
    NSError *_lastError;//错误
	NSMutableData *data;//data
    
    LastExecutionResult _lastExecutionResult;//执行结果
    
    NSURL *_url;//url
    CTURLConnectionOperation *_connectionOp;//connectionOp
    int _previousTag;//
}
@property(nonatomic,readwrite)int _serviceTag;
@property(nonatomic,assign)id<CTWebServiceDelegate> _delegate;
@property(nonatomic,readwrite)NSUInteger _retries;//重试次数
@property(nonatomic,retain)NSError *_lastError;//错误
@property(nonatomic,retain)NSMutableData *data;//data

@property(nonatomic,readonly)LastExecutionResult _lastExecutionResult;

- (void) cancelLoading;
-(void)clearData;
-(void)startWithUrl:(NSString*)urlString;
-(BOOL)isWorking;
-(void)postWidthUrl:(NSString *)urlString data:(NSData *)postData;
@end
