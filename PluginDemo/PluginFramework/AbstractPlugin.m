//
//  AbstractPlugin.m
//  PluginDemo
//
//  Created by kesalin on 10/27/11.
//  Copyright 2011 kesalin@gmail.com. All rights reserved.
//

#import "AbstractPlugin.h"

#define kErrFormat @"%s not implemented in subclass %@"
#define kExceptName @"Not Implemented"

@implementation AbstractPlugin

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)name
{
    NSString *reason = [NSString stringWithFormat:kErrFormat, _cmd, [self class]];
	@throw [NSException exceptionWithName:kExceptName 
                                   reason:reason 
                                 userInfo:nil];

}

- (IBAction)run:(id)sender
{
    NSString *reason = [NSString stringWithFormat:kErrFormat, _cmd, [self class]];
	@throw [NSException exceptionWithName:kExceptName 
                                   reason:reason 
                                 userInfo:nil];

}

@end
