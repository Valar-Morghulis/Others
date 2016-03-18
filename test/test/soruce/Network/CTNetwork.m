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

@interface CTNetwork()

@property(nonatomic,retain) NSDictionary * _data;
@end
@implementation CTNetwork
@synthesize _data;
@synthesize _delegate;
@synthesize _netTag;

-(id)init
{
    if(self = [super init])
    {
        self._serviceDelegate = self;//
    }
    return self;
}
-(void)dealloc
{
    self._serviceDelegate = 0;
    self._data = 0;
    [super dealloc];
}
-(NSDictionary *)backup
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:[super backup]];
    if(self._delegate)
        [dic setObject:self._delegate forKey:@"_delegate"];
    [dic setObject:[NSNumber numberWithInt:self._netTag] forKey:@"_netTag"];
    return dic;
}
-(void)resume:(NSDictionary *)dic
{
    [super resume:dic];
    self._delegate = [dic objectForKey:@"_delegate"];
    self._netTag = [[dic objectForKey:@"_netTag"] intValue];
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
    NSString* parameter = [CTNetwork getParameterString:mutableDic];
    
    NSString* postStr = [NSString stringWithFormat:@"%@%@",CTNETWORK_SERVER_URL,method];
    if(parameter)
    {
        postStr = [NSString stringWithFormat:@"%@?%@",postStr,parameter];
    }
    [self httpRequestWithURL:postStr];
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
                              initWithBytes:[engine._cacheData bytes]
                              length:[engine._cacheData length]
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
    //check backup
    
}

-(void)httpRequestWithPlatformDIC:(NSDictionary *)dic//平台接口
{
    NSString * totalUrl = [NSString stringWithFormat:@"%@?%@",CTNETWORK_SERVER_URL, [CTNetwork getPlatformSiginedUrl:dic]];
    [self httpRequestWithURL:totalUrl];
}


+(NSString *)getPlatformSiginedUrl:(NSDictionary *)dic
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
    [mutableDic setObject:[CTUtility getUDIDWidthKeyChain] forKey:@"deviceid"];
    [mutableDic setObject:API_VERSION forKey:@"api_version"];
    [mutableDic setObject:[CTUtility generateNonce] forKey:@"nonce"];
    [mutableDic setObject:CHANNEL_ID forKey:@"channel_id"];
    //
    [mutableDic setObject:APP_IMEI forKey:@"imei"];
    [mutableDic setObject:APP_IMSI forKey:@"imsi"];
    [mutableDic setObject:[CTUtility generateTimestamp] forKey:@"timestamp"];
    
    NSString* parameter = [self getParameterString:mutableDic];
    NSString* url = [CTUtility URLEncode:CTNETWORK_SERVER_URL];
    NSString* paraEncodeString = [CTUtility URLEncode:parameter];
    
    NSString* decRes = [NSString stringWithFormat:@"%@%@", url, paraEncodeString];
    
    decRes = [CTUtility base64StringWithHMACSHA1Digest:decRes key:APP_SECRET];
    
    NSString* signature = [CTUtility URLEncode:decRes];
    //
    
    NSString* postStr = [NSString stringWithFormat:@"%@&sign=%@", parameter, signature];
    return postStr;
}
+(NSMutableArray *)bubbleSortDictionaryByKeys:(NSDictionary *)dict
{
    if(!dict)
        return nil;
    NSMutableArray *sortedKeys = [NSMutableArray arrayWithArray: [dict allKeys]];
    if([sortedKeys count] <= 0)
        return nil;
    else if([sortedKeys count] == 1)
        return sortedKeys; //no sort needed
    
    //perform bubble sort on keys:
    int n = [sortedKeys count] -1;
    int i;
    BOOL swapped = YES;
    
    NSString *key1,*key2;
    NSComparisonResult result;
    
    while(swapped)
    {
        swapped = NO;
        for(i=0;i<n;i++)
        {
            key1 = [sortedKeys objectAtIndex: i];
            key2 = [sortedKeys objectAtIndex: i+1];
            
            result = [key1 compare: key2 ];
            if(result == NSOrderedDescending)
            {
                [key1 retain];
                [key2 retain];
                
                //pop the two keys out of the array
                [sortedKeys removeObjectAtIndex: i]; // key1
                [sortedKeys removeObjectAtIndex: i]; // key2
                //replace them
                [sortedKeys insertObject: key1 atIndex: i];
                [sortedKeys insertObject: key2 atIndex: i];
                
                [key1 release];
                [key2 release];
                
                swapped = YES;
            }
        }
    }
    
    return sortedKeys;
}

+(NSString *)getParameterString:(NSDictionary *)dic
{
    NSMutableArray* arr = [self bubbleSortDictionaryByKeys:dic];
    
    NSMutableString* paraString = [[NSMutableString alloc] init];
    
    for (NSInteger j = 0; j < [arr count]; j++) {
        id str = [dic objectForKey:[arr objectAtIndex:j]];
        if(![str isKindOfClass:[NSString class]])
        {
            str = [NSString stringWithFormat:@"%@",str];
        }
        NSString* value = [CTUtility URLEncode:str];
        NSString* temp2 = [NSString stringWithFormat:@"%@=%@&", [arr objectAtIndex:j], value];
        [paraString appendString:temp2];
    }
    NSString * str = 0;
    if([paraString length] > 0)
    {
        str = [NSString stringWithFormat:@"%@", [paraString substringToIndex:[paraString length] - 1]];
    }
    [paraString release];
    return str;
}


@end
