//
//  CTURLConnectionOperation.m
//  testApp
//
//  Created by MaYing on 13-9-4.
//  Copyright (c) 2013年 MaYing. All rights reserved.
//

#import "CTURLConnectionOperation.h"
@interface CTURLConnectionOperation () <NSURLConnectionDelegate, NSURLConnectionDataDelegate>
@property(retain) NSURLConnection *connection;
@property(retain) NSPort* port;

@property BOOL executing;
@property BOOL finished;

- (void)completeOperation;

@end

@implementation CTURLConnectionOperation
@synthesize connection = _connection;
@synthesize executing = _executing;
@synthesize finished = _finished;
@synthesize port = _port;

- (id)init {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (id)initWithRequest:(NSURLRequest *)request delegate:(id)delegate
{
    self = [super init];
    if (self) {
        _connection = [[NSURLConnection alloc] initWithRequest:request delegate:delegate startImmediately:NO];
        self.port = [NSPort port];
    }
    return self;
}

- (void)dealloc {
    
    [_connection cancel];
    [_connection release];
    
    [[NSRunLoop mainRunLoop] removePort:self.port forMode:NSDefaultRunLoopMode];
    [_port release];
    
    [super dealloc];
}

#pragma mark - overridden NSOperation methods

- (void)start
{
    // Always check for cancellation before launching the task.
    if ([self isCancelled])
    {
        // Must move the operation to the finished state if it is canceled.
        [self willChangeValueForKey:@"isFinished"];
        
        self.finished = YES;
        
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    
    // If the operation is not canceled, begin executing the task.
    [self willChangeValueForKey:@"isExecuting"];
    
    //the magical run loop trick will force NSURLConnection to call the delegate methods on main thread
    [[NSRunLoop mainRunLoop] addPort:self.port forMode:NSDefaultRunLoopMode];
    [_connection scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self.executing = YES;
    [self.connection start];
    [[NSRunLoop mainRunLoop] run];
    
    
    
    [self didChangeValueForKey:@"isExecuting"];
}

- (BOOL)isConcurrent
{
    return YES;
}

- (BOOL)isExecuting
{
    return self.executing;
}

- (BOOL)isFinished
{
    return self.finished;
}

- (void)cancel
{
    [super cancel];
    
    if ([self isExecuting]) {
        [self.connection cancel];
        [self completeOperation];
    }
}

#pragma mark - private methods

- (void)completeOperation
{
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    
    self.executing = NO;
    self.finished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

@end