//
//  DES.h
//  XF_BusinessCard
//
//  Created by MaYing on 15/5/14.
//  Copyright (c) 2015年 xiaofu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import<CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"
@interface DES : NSObject
+ (NSString *)encryptWithText:(NSString *)sText key:(NSString *)key;//加密
+ (NSString *)decryptWithText:(NSString *)sText key:(NSString *)key;//解密



@end
