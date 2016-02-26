//
//  PluginOne.m
//  PluginDemo
//
//  Created by kesalin on 10/27/11.
//  Copyright 2011 kesalin@gmail.com. All rights reserved.
//

#import "PluginOne.h"

@implementation PluginOne

@synthesize mainWindow;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        
        [NSBundle loadNibNamed:@"PluginOneMainWindow" owner:self];
    }
    
    return self;
}

- (void)dealloc
{
    mainWindow = nil;

    [super dealloc];
}

- (NSString *)name;
{
	return @"Plugin One";
}

- (IBAction)run:(id)sender;
{
	[mainWindow center];
	[mainWindow makeKeyAndOrderFront:sender];
}

- (IBAction)closeWindow:(id)sender;
{
	[mainWindow orderOut:sender];
}

@end
