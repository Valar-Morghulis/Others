//
//  CTUtility(UPYun).h
//  XF_BusinessCard
//
//  Created by MaYing on 15/1/26.
//  Copyright (c) 2015年 xiaofu. All rights reserved.
//

#import "CTUtility.h"

#include <sys/stat.h>
#include "upyun.h"
#import "GC_ConstantDefine.h"

@interface CTUtility(UPYun)
+(void)uploadFileToUP:(NSString *)filePath newFileName:(NSString *) newFileName successBlock:(void (^)(void))successBlock errorBlock:(void (^)(void))errorBlock;//
@end
