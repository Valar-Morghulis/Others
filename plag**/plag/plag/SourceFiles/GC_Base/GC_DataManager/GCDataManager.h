//
//  GCDataManager.h
//  ShoppingInLZ
//
//  Created by MaYing on 14-5-29.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GC_ConstantDefine.h"

@interface GCDataManager : NSObject
{
    NSMutableDictionary * _dic;
 
}
+(GCDataManager *)instance;

@property(nonatomic,assign) NSDictionary * _configData;//配置数据


@end
