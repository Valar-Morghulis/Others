//
//  CTWebService.m
//  testApp
//
//  Created by MaYing on 13-9-4.
//  Copyright (c) 2013年 MaYing. All rights reserved.
//

#import "CTWebService.h"


NSUInteger CTWebServiceRetries = 0;//重复次数
NSUInteger CTWebServiceMaxConcurrentConnections = 10;//
double CTWebServiceDefaultTimeOutInterval = 60;//超时时间
NSString *  CTWebServiceErrorDomain = @"CTWebServiceErrorDomain";
NSString * CTWebServiceHTTPResponseCodeKey = @"CTWebServiceHTTPResponseCodeKey";
NSString * CTWebServiceNotificationErrorKey = @"CTWebServiceNotificationErrorKey";

static NSMutableDictionary * _backupCache = 0;//记录backup
static NSOperationQueue *_queue = nil;

@interface  CTWebService()
@property(nonatomic,retain) NSURL *_url;//url
@property(nonatomic,retain) CTURLConnectionOperation *_connectionOp;//connectionOp
@property(nonatomic,retain)NSError *_lastError;//错误
@property(nonatomic,retain) NSMutableData *_cacheData;//
@property(nonatomic,readwrite)LastExecutionResult _lastExecutionResult;
@property(nonatomic,readwrite)BOOL _resumeAndRetry;//标记
//
@property(nonatomic,readwrite) NSUInteger _retriesInner;//
//
@property(nonatomic,retain) NSData * _postData;//记录post数据
@end


@implementation CTWebService
@synthesize _serviceDelegate;
@synthesize _retries;
@synthesize _lastError;
@synthesize _cacheData;
@synthesize _postData;
@synthesize _lastExecutionResult;
@synthesize _connectionOp;
@synthesize _url;
@synthesize _retriesInner;
@synthesize _resumeAndRetry;
+ (void) initialize
{
    _queue = [[NSOperationQueue alloc] init];
    [_queue setMaxConcurrentOperationCount:CTWebServiceMaxConcurrentConnections];
    _backupCache = [[NSMutableDictionary alloc] init];
    //
    //_cache 结构
    /*
     key :webservice地址 ---> {
     key :service ----> webservice,
     key : backup ---> [backup1 ,backup2]
     }
     */
}
-(id)init
{
    if(self = [super init])
    {
        self._retries = CTWebServiceRetries;
        self._lastExecutionResult = Result_None;
        _resumeAndRetry = FALSE;//
    }
    return self;
}
- (void) dealloc
{
	[self cancelLoading_inner:TRUE];
    [self clearData];
	[super dealloc];
}
-(NSDictionary *)backup
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    if(self._serviceDelegate)
        [dic setObject:self._serviceDelegate forKey:@"_serviceDelegate"];
    if(self._url)
        [dic setObject:self._url forKey:@"_url"];
    if(self._postData)
        [dic setObject:self._postData forKey:@"_postData"];
    [dic setObject:[NSNumber numberWithInteger:self._retries] forKey:@"_retries"];
    return dic;
}
-(void)resume:(NSDictionary *)dic
{
    self._serviceDelegate = [dic objectForKey:@"_serviceDelegate"];
    self._url = [dic objectForKey:@"_url"];
    self._postData = [dic objectForKey:@"_postData"];
    self._retries = [[dic objectForKey:@"_retries"] integerValue];
}
-(void)resumeAndRetry:(NSDictionary *)dic
{
    [self resume:dic];
    _resumeAndRetry = TRUE;//标记
    [self retry];
}
- (void) cancelLoading
{
    [self cancelLoading_inner:TRUE];
}
- (void) cancelLoading_inner:(BOOL)sendMessage
{
	if (self._connectionOp)
    {
        self._lastExecutionResult = Result_Canceld;
        [self._connectionOp cancel];
    
        self._connectionOp = 0;
        if(sendMessage)
        {
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startLoading) object:0];//cancel
            if(self._serviceDelegate)
                [_serviceDelegate afterWebServiceEnd:self];
        }
    }
}
-(void)clearData
{
    self._url = 0;
    self._postData = 0;
    self._lastError = 0;
    self._cacheData = 0;
}
-(BOOL)isWorking
{
    return self._connectionOp != 0;
}
//
- (void)startLoading
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self._url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:CTWebServiceDefaultTimeOutInterval];
    
    self._connectionOp = [[[CTURLConnectionOperation alloc] initWithRequest:request delegate:self] autorelease];
    if(self._postData)
    {
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:self._postData];
    }
    [_queue addOperation:self._connectionOp];
}

-(void)httpRequestWithURL:(NSString*)urlString
{
    [self cancelLoading_inner:TRUE];
    [self clearData];//清空buf
    NSLog(@"url: %@", urlString);
    self._url = [[[NSURL alloc] initWithString:urlString] autorelease];
    [self retry];
}
-(void)postWidthUrl:(NSString *)urlString data:(NSData *)postData
{
    [self cancelLoading_inner:TRUE];
    [self clearData];//清空buf
    self._postData = postData;//
    self._url = [[[NSURL alloc] initWithString:urlString] autorelease];
    [self retry];
}
-(void)retry
{
    self._retriesInner = self._retries;
    self._cacheData = [[[NSMutableData alloc] initWithCapacity:0] autorelease];
    if(self._serviceDelegate)
    {
        [self._serviceDelegate beforWebServiceStart:self];
    }
    [self requestData];
}
-(void)requestData
{
	if (self._connectionOp) // re-request
	{
        [self._connectionOp cancel];
        self._connectionOp = 0;
        
		if(self._retriesInner == 0) // No more retries
		{
            self._lastError = [NSError errorWithDomain:CTWebServiceErrorDomain
                                                  code:CTWebServiceHTTPStatus500Error
                                              userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                                                        NSLocalizedString(@"HTTP Status 500", @""), NSLocalizedDescriptionKey, nil]];
           self._lastExecutionResult = Result_Error;
            if(self._serviceDelegate)
            {
                [self._serviceDelegate afterWebServiceEnd:self];
            }
            [self cancelLoading_inner:FALSE];
            //[self clearData];
			return;
		}
		_retriesInner--;
        [self performSelector:@selector(startLoading) withObject:0 afterDelay:1.0];
		
	}
	else
	{
        [self startLoading];
	}
    
}


#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    int statusCode = NSURLErrorUnknown; // unknown
	if ([response isKindOfClass:[NSHTTPURLResponse class]])
        statusCode = [(NSHTTPURLResponse*)response statusCode];
	
    [self._cacheData setLength:0];
    
	if(statusCode < 400)
    { // Success
	}
	else if (statusCode == 404)
    { // Not Found
        [self cancelLoading_inner:FALSE];
        self._lastError  = [NSError errorWithDomain:CTWebServiceErrorDomain
                                               code:CTWebServiceNotFoundResponse
                                           userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                                                     NSLocalizedString(@"The requested tile was not found on the server", @""), NSLocalizedDescriptionKey, nil]];
        _lastExecutionResult = Result_Error;
        if(self._serviceDelegate)
        {
            [self._serviceDelegate afterWebServiceEnd:self];
        }
        //[self clearData];
	}
	else
    {  // Other Error
		BOOL retry = FALSE;
		switch(statusCode) {
                /// \bug magic number
			case 500: retry = TRUE; break;
			case 503: retry = TRUE; break;
		}
		
        NSError *error = [NSError errorWithDomain:CTWebServiceErrorDomain
                                             code:CTWebServiceUnexpectedHTTPResponse
                                         userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                                                   [NSNumber numberWithInt:statusCode], CTWebServiceHTTPResponseCodeKey,
                                                   [NSString stringWithFormat:NSLocalizedString(@"The server returned error code %d", @""), statusCode], NSLocalizedDescriptionKey, nil]];
        
        self._lastError = error;
		if (retry)
        {
			[self requestData];
		}
        else
        {
            [self cancelLoading_inner:FALSE];
            self._lastExecutionResult = Result_Error;
            if(self._serviceDelegate)
            {
                [self._serviceDelegate afterWebServiceEnd:self];
            }
            //[self clearData];
        }
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)newData
{
	[self._cacheData appendData:newData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    BOOL retry = FALSE;
	
	switch([error code])
	{
            /**
             * 如果需要错误后重试，再次修改
             */
        case NSURLErrorBadURL:                      // -1000
        case NSURLErrorTimedOut:                    // -1001
        case NSURLErrorUnsupportedURL:              // -1002
        case NSURLErrorCannotFindHost:              // -1003
        case NSURLErrorCannotConnectToHost:         // -1004
        case NSURLErrorNetworkConnectionLost:       // -1005
        case NSURLErrorDNSLookupFailed:             // -1006
        case NSURLErrorResourceUnavailable:         // -1008
        case NSURLErrorNotConnectedToInternet:      // -1009
            break;
        default:
            break;
	}
	self._lastError = error;
	if(retry)
	{
		[self requestData];
	}
	else
	{
        [self cancelLoading_inner:FALSE];
        self._lastExecutionResult = Result_Error;
        if(self._serviceDelegate)
        {
            [self._serviceDelegate afterWebServiceEnd:self];
        }
        //[self clearData];
	}
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if ([self._cacheData length] == 0)
    {
        /*
         ----old-----
        self._lastError = [[NSError errorWithDomain:CTWebServiceErrorDomain
                                               code:CTWebServiceZeroLengthResponse
                                           userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                                                     NSLocalizedString(@"The server returned a zero-length response", @""), NSLocalizedDescriptionKey, nil]] retain];
         */
        self._lastError = [NSError errorWithDomain:CTWebServiceErrorDomain
                                               code:CTWebServiceZeroLengthResponse
                                           userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                                                     NSLocalizedString(@"The server returned a zero-length response", @""), NSLocalizedDescriptionKey, nil]];
		[self requestData];
	}
    else
    {
        [self cancelLoading_inner:FALSE];
        self._lastExecutionResult = Result_Succeed;
        if(self._serviceDelegate)
        {
            [self._serviceDelegate afterWebServiceEnd:self];
        }
        //[self clearData];
        //
        if(_resumeAndRetry)
        {
            NSDictionary * dic = [CTWebService popBackup:self];
            if(dic)
            {
                [self resumeAndRetry:dic];
            }
            else
            {
                _resumeAndRetry = FALSE;//标记
            }
        }
    }
}





//
+(void)pushBackup:(CTWebService *)service
{
    NSString * key = [NSString stringWithFormat:@"%p",service];
    NSMutableDictionary * value = [_backupCache objectForKey:key];
    if(!value)
    {
        value = [NSMutableDictionary dictionary];
        [_backupCache setObject:value forKey:key];
        [value setObject:service forKey:@"service"];
    }
    NSMutableArray * array = [value objectForKey:@"backup"];
    if(!array)
    {
        array = [NSMutableArray array];
        [value setObject:array forKey:@"backup"];
    }
    [array addObject:[service backup]];
}
+(NSDictionary *)popBackup:(CTWebService *)service
{
    if(service)
    {
        NSString * key = [NSString stringWithFormat:@"%p",service];
        NSMutableDictionary * value = [_backupCache objectForKey:key];
        if(value)
        {
            NSMutableArray * array = [value objectForKey:@"backup"];
            if(array && [array count] > 0)
            {
                NSDictionary * res = [[array lastObject] retain];
                [array removeObject:res];
                return [res autorelease];
            }
            else
            {
                [_backupCache removeObjectForKey:key];//
            }
        }
    }
    return 0;
}
+(void)resumeAndRetry:(CTWebService *)service
{
    NSDictionary * dic = [self popBackup:service];
    if(dic)
    {
        [service resumeAndRetry:dic];//
    }

}
+(void)resumeAndRetryAll
{
    [_backupCache enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        CTWebService * service = [obj objectForKey:@"service"];
        [self resumeAndRetry:service];
    }];
}
+(void)cleanup:(CTWebService *)service
{
    NSString * key = [NSString stringWithFormat:@"%p",service];
    [_backupCache removeObjectForKey:key];
}
+(void)cleanupAll
{
    [_backupCache removeAllObjects];//
}



@end
