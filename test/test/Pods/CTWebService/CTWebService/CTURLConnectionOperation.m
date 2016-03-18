//
//  CTURLConnectionOperation.m
//  testApp
//
//  Created by MaYing on 13-9-4.
//  Copyright (c) 2013年 MaYing. All rights reserved.
//

#import "CTURLConnectionOperation.h"
@interface CTURLConnectionOperation () <NSURLConnectionDelegate, NSURLConnectionDataDelegate>
@property(nonatomic,retain) NSURLConnection *_connection;
@property(nonatomic,retain) NSPort* _port;
@property BOOL _executing;
@property BOOL _finished;
- (void)completeOperation;

@end

@implementation CTURLConnectionOperation


- (id)init
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (id)initWithRequest:(NSURLRequest *)request delegate:(id)delegate
{
    self = [super init];
    if (self) {
        self._connection = [[[NSURLConnection alloc] initWithRequest:request delegate:delegate startImmediately:FALSE] autorelease];
        self._port = [NSPort port];
    }
    return self;
}

- (void)dealloc
{
    [self._connection cancel];
    self._connection = 0;
    
    [[NSRunLoop mainRunLoop] removePort:self._port forMode:NSDefaultRunLoopMode];
    self._port = 0;
    
    [super dealloc];
}

#pragma mark - overridden NSOperation methods

- (void)start
{
    // Always check for cancellation before launching the task.
    if ([self isCancelled])
    {
        [self willChangeValueForKey:@"isFinished"];
        
        self._finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
 
    [self willChangeValueForKey:@"isExecuting"];
    [[NSRunLoop mainRunLoop] addPort:self._port forMode:NSDefaultRunLoopMode];
    [self._connection scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self._executing = YES;
    [self._connection start];
    [[NSRunLoop mainRunLoop] run];
    
    [self didChangeValueForKey:@"isExecuting"];
}

- (BOOL)isConcurrent
{
    return YES;
}

- (BOOL)isExecuting
{
    return self._executing;
}

- (BOOL)isFinished
{
    return self._finished;
}

- (void)cancel
{
    [super cancel];
    
    if ([self isExecuting])
    {
        [self._connection cancel];
        [self completeOperation];
    }
}

#pragma mark - private methods

- (void)completeOperation
{
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    
    self._executing = NO;
    self._finished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

@end