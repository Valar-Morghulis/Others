//
//  CheckAndRunApplication.m
//  testApp
//
//  Created by MaYing on 13-8-21.
//  Copyright (c) 2013年 MaYing. All rights reserved.
//

#import "CheckAndRunApplication.h"
#define MOBILE_INSTALLATION_LIB_PATH "/System/Library/PrivateFrameworks/MobileInstallation.framework/MobileInstallation"
#import <dlfcn.h>
typedef int (*MobileInstallationBrowse)(NSDictionary *options, int (*callback)(NSDictionary *dict, id value), id value);

static CheckAndRunApplication * _instance = 0;

static int callback(NSDictionary *dict, id result)
{
    NSArray *currentList = [dict objectForKey:@"CurrentList"];
    if (currentList)
    {
        for (NSDictionary *appInfo in currentList)
        {
            [(NSMutableArray*)result addObject:[[appInfo copy] autorelease]];
        }
    }
    return 0;
}


@implementation CheckAndRunApplication

-(id)init
{
    if(self = [super init])
    {
#if 0
        void *lib = dlopen(MOBILE_INSTALLATION_LIB_PATH, RTLD_LAZY);
        if (lib)
        {
            MobileInstallationBrowse pBrowse = (MobileInstallationBrowse)dlsym(lib, "MobileInstallationBrowse");
            [self browse:pBrowse];
            dlclose(lib);
            
        }
#else
        _currentApplicationArray = [NSMutableArray new];
#endif
    }
    return self;
}
-(void)dealloc
{
    [_currentApplicationArray release];
    [super dealloc];
}

-(void)browse:(MobileInstallationBrowse) browse
{
    _currentApplicationArray = [NSMutableArray new];
    browse( [NSDictionary dictionaryWithObject:@"User"   forKey:@"ApplicationType"],&callback, _currentApplicationArray);//Any User System
}

-(BOOL)isApplicationEixstByIdentifier:(NSString *)identifier
{
    BOOL res = FALSE;
    for(int i = 0;i <[_currentApplicationArray count];i++)
    {
        NSDictionary *appInfo = [_currentApplicationArray objectAtIndex:i];
        if(appInfo)
        {
            NSString * appIdentifier = [appInfo objectForKey:@"CFBundleIdentifier"];
            if(appIdentifier && [appIdentifier isEqualToString:identifier])
            {
                res = TRUE;
                break;
            }
        }
    }
    return res;
}
-(BOOL)runApplicationByIdentifier:(NSString*)identifier
{
    BOOL res = FALSE;
    for(int i = 0;i <[_currentApplicationArray count];i++)
    {
        NSDictionary *appInfo = [_currentApplicationArray objectAtIndex:i];
        if(appInfo)
        {
            NSString * appIdentifier = [appInfo objectForKey:@"CFBundleIdentifier"];
            if(appIdentifier && [appIdentifier isEqualToString:identifier])
            {
                NSArray *bundleURLTypes = [appInfo objectForKey:@"CFBundleURLTypes"];
                if(bundleURLTypes)
                {
                    for(int j = 0;j < [bundleURLTypes count];j++)
                    {
                        NSDictionary* bundleURLSchemesDic = [bundleURLTypes objectAtIndex:j];
                        if(bundleURLSchemesDic)
                        {
                            NSArray * bundleURLSchemes = [bundleURLSchemesDic objectForKey:@"CFBundleURLSchemes"];
                            if(bundleURLSchemes)
                            {
                                for(int k = 0;k < [bundleURLSchemes count];k++)
                                {
                                    NSString * urlScheme = [bundleURLSchemes objectAtIndex:k];
                                    if(urlScheme)
                                    {
                                        res = [self runApplicationByURLScheme:urlScheme];
                                        break;
                                    }
                                }
                                if(res)
                                    break;
                            }
                            
                        }
                        
                    }
                }
                break;
            }
        }
    }
    return res;
}
-(BOOL)runApplicationByURLScheme:(NSString*)urlScheme
{
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@:",urlScheme]]];
}
+(id)instance
{
    if(!_instance)
        _instance = [[CheckAndRunApplication alloc] init];
    return _instance;
}
@end

