//
//  GCLoginManager.m
//  Cofcofuture
//
//  Created by MaYing on 14-4-10.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import "GCLoginManager.h"
#import "YAJL.h"
#define GCLoginManagerConfigFileName @"GCLoginManager.txt"
static GCLoginManager * _instance = 0;
@implementation GCLoginManager
@synthesize _configFilePath;
//
@synthesize _isLogin;
@synthesize _isRecord;
@synthesize _userName;
@synthesize _userInfo;

-(id)init
{
    if(self = [super init])
    {
        _isLogin = FALSE;
        
        NSArray*paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString*documentsDirectory =[paths objectAtIndex:0];
        NSString * fileName = GCLoginManagerConfigFileName;
        self._configFilePath =[documentsDirectory stringByAppendingPathComponent:fileName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSDictionary * dic = 0;
        if(![fileManager fileExistsAtPath:self._configFilePath])
        {
            //复制
            NSString * oldPath = [[NSBundle mainBundle] pathForResource:fileName ofType:0];
            if([fileManager fileExistsAtPath:oldPath])
            {
                [fileManager copyItemAtPath:oldPath toPath:self._configFilePath error:0];
            }
        }
        
        if([fileManager fileExistsAtPath:self._configFilePath])
        {
            NSData * data = [NSData dataWithContentsOfFile:self._configFilePath];
            NSString * content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            dic = [content yajl_JSON];
            [content release];
            _loginData = [[NSMutableDictionary alloc] initWithDictionary:dic];
        }

    }
    return  self;
}
-(void)dealloc
{
    self._configFilePath = 0;
    self._userInfo = 0;
    [super dealloc];
}
-(BOOL)_isLogin
{
    return[ [_loginData objectForKey:@"isLogin"] boolValue];
}
-(void)set_isLogin:(BOOL)isLogin
{
    [_loginData setObject:[NSNumber numberWithBool:isLogin] forKey:@"isLogin"];
}
-(BOOL)_isRecord
{
    return[ [_loginData objectForKey:@"isRecord"] boolValue];
}
-(void)set_isRecord:(BOOL)isRecord
{
    [_loginData setObject:[NSNumber numberWithBool:isRecord] forKey:@"isRecord"];
    [self update];
}
-(NSString *)_userName
{
    return [_loginData objectForKey:@"userName"];
}
-(void)set_userName:(NSString *)userName
{
    if(userName)
        [_loginData setObject:userName forKey:@"userName"];
    else
    {
        [_loginData removeObjectForKey:@"userName"];
    }
    [self update];
}
-(void)update
{
    NSString * content = @"";
    if(!self._isRecord)
    {
        [_loginData setObject:@"" forKey:@"userName"];
    }

    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:self._userName,@"userName",[NSNumber numberWithBool:self._isRecord],@"isRecord",nil];
    content = [dic yajl_JSONString];
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    [contentData writeToFile:self._configFilePath atomically:YES];
}
+(GCLoginManager *)instance
{
    if(!_instance)
    {
        _instance = [[GCLoginManager alloc] init];
    }
    return  _instance;
}
@end
