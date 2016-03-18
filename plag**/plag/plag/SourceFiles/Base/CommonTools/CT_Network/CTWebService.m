//
//  CTWebService.m
//  testApp
//
//  Created by MaYing on 13-9-4.
//  Copyright (c) 2013年 MaYing. All rights reserved.
//

#import "CTWebService.h"

#import "CTWebService.h"

static NSOperationQueue *_queue = nil;

@interface  CTWebService()
@end


@implementation CTWebService
@synthesize _delegate;
@synthesize _serviceTag;
@synthesize _retries;
@synthesize _lastError;
@synthesize data;
@synthesize _lastExecutionResult;

-(void)set_serviceTag:(int)newTag
{
    _previousTag = _serviceTag;
    _serviceTag = newTag;
}
+ (void) initialize
{
    _queue = [[NSOperationQueue alloc] init];
    [_queue setMaxConcurrentOperationCount:ISMaxConcurrentConnections];
}
-(id)init
{
    if(self = [super init])
    {
        _retries = CTWebTileRetries;
        _lastExecutionResult = Result_None;
        _previousTag = -1;
    }
    return self;
}
-(void)clearData
{
    self._lastError = nil;
    self.data = nil;
}
- (void) dealloc
{
	[self cancelLoading_inner:TRUE];
    [self clearData];
	[super dealloc];
}
- (void)startLoading:(NSTimer *)timer
{
	NSURLRequest *request = [NSURLRequest requestWithURL:_url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:DEFAULT_TIMEOUTINTERVAL];
    
    _connectionOp = [[CTURLConnectionOperation alloc] initWithRequest:request delegate:self];
    [_queue addOperation:_connectionOp];
}
- (void) cancelLoading
{
    [self cancelLoading_inner:TRUE];
}
- (void) cancelLoading_inner:(BOOL)sendMessage
{
	if (_connectionOp)
    {
        _lastExecutionResult = Result_Canceld;
        [_connectionOp cancel];
        [_connectionOp release];
        _connectionOp = nil;
        if(sendMessage && _delegate)
        {
            [_delegate afterWebServiceEnd:self];
        }
        
    }
    if (_url) [_url release]; _url = nil;
}

-(BOOL)isWorking
{
    return _connectionOp != 0;
}
- (void)startWithUrl:(NSString*)urlString
{
    [self cancelLoading_inner:TRUE];
    
    [self clearData];//清空buf
    _url = [[NSURL alloc] initWithString:urlString];
    NSMutableData * tData =[[NSMutableData alloc] initWithCapacity:0];
    self.data = tData;
    [tData release];
    if(_delegate)
    {
        [_delegate beforWebServiceStart:self];
    }
    [self requestData];
    
}
-(void)postWidthUrl:(NSString *)urlString data:(NSData *)postData
{
    [self cancelLoading_inner:TRUE];
    [self clearData];//清空buf
    _url = [[NSURL alloc] initWithString:urlString];
    NSMutableData * tData =[[NSMutableData alloc] initWithCapacity:0];
    self.data = tData;
    [tData release];
    if(_delegate)
    {
        [_delegate beforWebServiceStart:self];
    }
    if (_connectionOp) // re-request
    {
        [_connectionOp cancel];
        [_connectionOp release];
        _connectionOp = nil;
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:DEFAULT_TIMEOUTINTERVAL];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    _connectionOp = [[CTURLConnectionOperation alloc] initWithRequest:request delegate:self];
    [_queue addOperation:_connectionOp];
    
}
-(void)requestData
{
	if (_connectionOp) // re-request
	{
        [_connectionOp cancel];
		[_connectionOp release];
		_connectionOp = nil;
        
		if(_retries == 0) // No more retries
		{
            self._lastError = [NSError errorWithDomain:CTWebServiceErrorDomain
                                                  code:CTWebServiceHTTPStatus500Error
                                              userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                                                        NSLocalizedString(@"HTTP Status 500", @""), NSLocalizedDescriptionKey, nil]];
            _lastExecutionResult = Result_Error;
            if(_delegate)
            {
                [_delegate afterWebServiceEnd:self];
            }
            [self cancelLoading_inner:FALSE];
            [self clearData];
			return;
		}
		_retries--;
        
		[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(startLoading:) userInfo:nil repeats:NO];
	}
	else
	{
		[self startLoading:nil];
	}
    
}


#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    int statusCode = NSURLErrorUnknown; // unknown
	if ([response isKindOfClass:[NSHTTPURLResponse class]])
        statusCode = [(NSHTTPURLResponse*)response statusCode];
	
    [self.data setLength:0];
    
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
        if(_delegate)
        {
            [_delegate afterWebServiceEnd:self];
        }
        [self clearData];
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
            _lastExecutionResult = Result_Error;
            if(_delegate)
            {
                [_delegate afterWebServiceEnd:self];
            }
            [self clearData];
        }
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)newData
{
	[self.data appendData:newData];
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
        _lastExecutionResult = Result_Error;
        if(_delegate)
        {
            [_delegate afterWebServiceEnd:self];
        }
        [self clearData];
	}
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{

    if ([data length] == 0)
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
        _lastExecutionResult = Result_Succeed;
        if(_delegate)
        {
            [_delegate afterWebServiceEnd:self];
        }
    }
}
@end
