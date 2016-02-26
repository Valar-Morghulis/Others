//
//  PluginDemoAppDelegate.h
//  PluginDemo
//
//  Created by kesalin on 10/27/11.
//  Copyright 2011 kesalin@gmail.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PluginDemoAppDelegate : NSObject <NSApplicationDelegate> {
@private
    NSWindow *window;
    NSArray *plugins;
    
    IBOutlet NSArrayController *pluginsController;
}

@property (nonatomic, assign) IBOutlet NSWindow *window;
@property (nonatomic, readonly, retain) NSArray *plugins;

- (IBAction)runPlugin:(id)sender;

@end
