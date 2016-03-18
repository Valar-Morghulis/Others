//
//  GCDataManager.m
//  ShoppingInLZ
//
//  Created by MaYing on 14-5-29.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import "GCDataManager.h"

#import "GC_ConstantDefine.h"
#import "YAJL.h"

#define GCHOME_DATA_FILE_NAME @"GCHomeData.txt"

static GCDataManager * _instance = 0;

@implementation GCDataManager

@synthesize _configData;


-(id)init
{
    if(self = [super init])
    {
        _dic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)dealloc
{
    [_dic release];
    [super dealloc];
}

+(GCDataManager *)instance
{
    if(!_instance)
    {
        _instance = [[GCDataManager alloc] init];
    }
    return _instance;
}

-(NSDictionary *)_configData
{
    return [_dic objectForKey:@"configData"];
}
-(void)set_configData:(NSDictionary *)configData
{
    if(configData)
    {
        [_dic setObject:configData forKey:@"configData"];
    }
    else
    {
        [_dic removeObjectForKey:@"configData"];
    }
}


@end
