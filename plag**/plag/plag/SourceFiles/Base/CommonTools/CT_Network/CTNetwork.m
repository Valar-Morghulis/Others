//
//  CTNetwork.m
//  BIPT_Base
//
//  Created by MaYing on 14-1-15.
//  Copyright (c) 2014年 Thinkfer. All rights reserved.
//

#import "CTNetwork.h"
#import "CTUtility.h"
#import "YAJL.h"

@implementation CTNetwork
@synthesize _webService;
@synthesize _data;
@synthesize _delegate;
@synthesize _netTag;
@synthesize _lastUrl;

-(id)init
{
    if(self = [super init])
    {
        CTWebService * service = [[CTWebService alloc] init];
        self._webService = service;
        [service release];
        self._webService._delegate = self;
    }
    return self;
}
-(void)dealloc
{
    self._webService._delegate = 0;
    self._webService = 0;
    self._data = 0;
    self._lastUrl = 0;
    [super dealloc];
}
-(void)httpRequestWithURL:(NSString *)url
{
    self._lastUrl = url;
    NSLog(@"total url: %@", url);
    [self._webService startWithUrl:url];
}
-(void)httpRequestWithDIC:(NSDictionary *)dic
{
    NSMutableDictionary* mutableDic = [[[NSMutableDictionary alloc] initWithDictionary:dic] autorelease];
    NSEnumerator* enumer = [[mutableDic allKeys] objectEnumerator];
    NSString* key;
    while (key = [enumer nextObject])
    {
        NSString* value = [mutableDic objectForKey:key];
        if (![value isKindOfClass:[NSString class]])
        {
            value = [NSString stringWithFormat:@"%@", value];
            [mutableDic setObject:value forKey:key];
        }
    }
    
    NSString* method = [mutableDic objectForKey:@"method"];
    [mutableDic removeObjectForKey:@"method"];
    NSString* parameter = [CTUtility getParameterString:mutableDic];
    
    NSString* postStr = [NSString stringWithFormat:@"%@%@",CTNETWORK_SERVER_URL,method];
    if(parameter)
    {
        postStr = [NSString stringWithFormat:@"%@?%@",postStr,parameter];
    }
    [self httpRequestWithURL:postStr];
}
-(void)cancel
{
    [self._webService cancelLoading];
}

#pragma mark CTWebServiceDelegate
-(void)beforWebServiceStart:(CTWebService*)engine
{
    self._data = 0;
    if(self._delegate)
    {
        [self._delegate beforeNetworkStart:self];
    }
}
-(void)afterWebServiceEnd:(CTWebService*)engine
{
    self._data = 0;
    int success = engine._lastExecutionResult;
    if(engine._lastExecutionResult == Result_Succeed)
    {
        NSString *results = [[[NSString alloc]
                              initWithBytes:[engine.data bytes]
                              length:[engine.data length]
                              encoding:NSUTF8StringEncoding] autorelease];
        NSError *error;
        self._data = [results yajl_JSON:&error];
        if(![self._delegate isResultVaild:self data:self._data])
        {
            success = Result_None;
        }
    }
    if(self._delegate )
    {
        [self._delegate networkStoped:self success:success];
        [self._delegate afterNetworkStoped:self];
    }
}
-(NSString *)getPlatformSiginedUrl:(NSDictionary *)dic;
{
    NSMutableDictionary* mutableDic = [[[NSMutableDictionary alloc] initWithDictionary:dic] autorelease];
    NSEnumerator* enumer = [[mutableDic allKeys] objectEnumerator];
    NSString* key;
    while (key = [enumer nextObject])
    {
        NSString* value = [mutableDic objectForKey:key];
        if (![value isKindOfClass:[NSString class]])
        {
            value = [NSString stringWithFormat:@"%@", value];
            [mutableDic setObject:value forKey:key];
        }
    }//
    [mutableDic setObject:APP_KEY forKey:@"appkey"];
    //[mutableDic setObject:SERVER_KEY forKey:@"serverkey"];
    [mutableDic setObject:[CTUtility getUUID] forKey:@"deviceid"];
    [mutableDic setObject:API_VERSION forKey:@"api_version"];
    [mutableDic setObject:[CTUtility generateNonce] forKey:@"nonce"];
    [mutableDic setObject:CHANNEL_ID forKey:@"channel_id"];
    //
    [mutableDic setObject:[CTUtility getIMEI] forKey:@"imei"];
    [mutableDic setObject:[CTUtility getIMSI] forKey:@"imsi"];
    [mutableDic setObject:[CTUtility generateTimestamp] forKey:@"timestamp"];
    
    NSString* parameter = [CTUtility getParameterString:mutableDic];
    NSString* url = [CTUtility URLEncode:CTNETWORK_SERVER_URL];
    NSString* paraEncodeString = [CTUtility URLEncode:parameter];
    
    NSString* decRes = [NSString stringWithFormat:@"%@%@", url, paraEncodeString];
    
    decRes = [CTUtility base64StringWithHMACSHA1Digest:decRes key:APP_SECRET];
    
    NSString* signature = [CTUtility URLEncode:decRes];
    //
    
    NSString* postStr = [NSString stringWithFormat:@"%@&sign=%@", parameter, signature];
    return postStr;
}
-(void)httpRequestWithPlatformDIC:(NSDictionary *)dic//平台接口
{
    NSString * totalUrl = [NSString stringWithFormat:@"%@?%@",CTNETWORK_SERVER_URL, [self getPlatformSiginedUrl:dic]];
    [self httpRequestWithURL:totalUrl];
}

-(void)postWidthUrl:(NSString *)urlString data:(NSData *)postData
{
    self._lastUrl = urlString;
    [self._webService postWidthUrl:self._lastUrl data:postData];//
}

@end
