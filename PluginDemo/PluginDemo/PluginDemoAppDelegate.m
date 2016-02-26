//
//  PluginDemoAppDelegate.m
//  PluginDemo
//
//  Created by kesalin on 10/27/11.
//  Copyright 2011 kesalin@gmail.com. All rights reserved.
//

#import "PluginDemoAppDelegate.h"
#import <PluginFramework/AbstractPlugin.h>

@interface PluginDemoAppDelegate(PrivateMethods)

- (NSArray *)loadPlugins;

@end

@implementation PluginDemoAppDelegate

@synthesize window;
@synthesize plugins;

- (id)init
{
    self = [super init];
    if (self) {
        plugins = [[self loadPlugins] retain];
    }
    
    return self;
}

- (void) dealloc
{
    [plugins release];
    plugins = nil;
    
    window = nil;

    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)runPlugin:(id)sender
{
    AbstractPlugin *plugin = [[pluginsController selectedObjects] lastObject];
	if (!plugin)
        return;

    [plugin run:sender];
}

- (NSArray *)loadPlugins
{
	NSBundle *main = [NSBundle mainBundle];
	NSArray *allPlugins = [main pathsForResourcesOfType:@"bundle" inDirectory:@"../PlugIns"];
	
	NSMutableArray *availablePlugins = [[[NSMutableArray alloc] init] autorelease];
	
	id plugin = nil;
	NSBundle *pluginBundle = nil;
	
	for (NSString *path in allPlugins) {
		pluginBundle = [NSBundle bundleWithPath:path];
		[pluginBundle load];
        
		Class principalClass = [pluginBundle principalClass];
		if (![principalClass isSubclassOfClass:[AbstractPlugin class]]) {
			continue;
		}
        
		plugin = [[principalClass alloc] init];
        
        if ([plugin respondsToSelector:@selector(run:)])
        {
            [availablePlugins addObject:plugin];
            NSLog(@" >> loading plugin %@ from %@", [plugin name], path);
        }
        
		[plugin release];
        plugin = nil;
		pluginBundle = nil;
	}

	return availablePlugins;
}

@end
