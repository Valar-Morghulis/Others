//
//  CTURLConnectionOperation.h
//  testApp
//
//  Created by MaYing on 13-9-4.
//  Copyright (c) 2013年 MaYing. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CTURLConnectionOperationDelegate

@end
@interface CTURLConnectionOperation : NSOperation

- (id)initWithRequest:(NSURLRequest *)request delegate:(id)delegate;

@end

