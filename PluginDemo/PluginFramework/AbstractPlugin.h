//
//  AbstractPlugin.h
//  PluginDemo
//
//  Created by kesalin on 10/27/11.
//  Copyright 2011 kesalin@gmail.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AbstractPlugin : NSObject {
@private
    
}

- (NSString *)name;

- (IBAction)run:(id)sender;

@end
