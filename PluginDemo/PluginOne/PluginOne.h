//
//  PluginOne.h
//  PluginDemo
//
//  Created by kesalin on 10/27/11.
//  Copyright 2011 kesalin@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PluginFramework/AbstractPlugin.h>

@interface PluginOne : AbstractPlugin {
@private
	NSWindow *mainWindow;
}

@property (nonatomic, readonly, assign) IBOutlet NSWindow *mainWindow;

- (IBAction)closeWindow:(id)sender;

@end
