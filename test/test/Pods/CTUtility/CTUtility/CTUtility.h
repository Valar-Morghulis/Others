//
//  CTUtility.h
//  libTest
//
//  Created by yaoyongping on 12-4-23.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonDigest.h>

#import "UIDevice+IdentifierAddition.h"
#import "CTAlertView.h"
#import "A0SimpleKeychain.h"

extern NSString * APP_CACHE_FOLDER;//


@interface CTUtility : NSObject

@end


@interface CTUtility(Parameters)//获取参数
+ (NSString *)getGUID;//并不是唯一的，每次获取都会改变
+(NSString *)getUDID;//并不是唯一的，每次获取都会改变
+(NSString *)getUDIDWidthKeyChain;//唯一
+(NSString *)getMacIdentifier;//获取根据mac地址生成的identifier,ios7.0之后不可以用
+ (NSString *)generateTimestamp;
+ (NSString *)generateNonce;

@end

@interface CTUtility(Encode_Decode)//加密编码
+ (NSString*)MD5Encode:(NSString*)input;
+ (NSString*)sha1:(NSString*)input;
+ (NSString*)URLEncode:(NSString*)str;
+ (NSString*)URLDecoded:(NSString*)str;

+ (NSString *)base64StringWithHMACSHA1Digest:(NSString *)strSource key:(NSString *)secretKey;
+ (NSString *)base64StringFromData:(NSData *)data length:(int)length;
@end


@interface CTUtility(Cache)//文件缓存

+(BOOL)isFileExist:(NSString *)fileName;
+(BOOL)cacheFileWidthData:(NSString *)fileName dicData:(NSDictionary *)dic;

+(BOOL)cacheImageWithName:(NSString *)imageName image:(UIImage *)image;
+(UIImage *)getCacheImageWithImageName:(NSString *)imagename;
+(NSString *)getCachePath;
+(void)clearCachData;

+(NSString *)pathForFileName:(NSString *)fileName;

@end



@interface CTUtility(Check)//数据校验

+(BOOL)isFloat:(NSString *)string;
//格式化字符串  将字符串两边空格去掉
+(NSString *)trim:(NSString *)string;
//验证邮箱地址是否合法
+(BOOL)isValidateEmail:(NSString *)email;
//比较是否为同一天
+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2;

@end



@interface CTUtility(Format)//格式转换

//按照key排序
+ (NSMutableArray *)bubbleSortDictionaryByKeys:(NSDictionary *)dict;
//格式化日期
+(NSString *)formatDateByString:(NSString *)inputDate;

+(CFGregorianDate)convertToCFGregorianDateFromNDate:(NSDate *)date;
//将字符串转换为日期
+(NSDate *)convertToDateFromString:(NSString *)inputDate;
+(NSDate *)convertToDateFromString:(NSString *)inputDate withformat:(NSString *)format;
//将日期转换为字符串格式
+(NSString *)convertToStringFromNSDate:(NSDate *)inpuDate;
//将日期转换为字符串格式
+(NSString *)convertToStringFromNSDate:(NSDate *)inpuDate withDataFormate:(NSString *)Formate;

//读取day
+(NSString *)getDayFromData:(NSDate *)date;

//读取week
+(NSString *)getWeekFromData:(NSDate *)date;

+(int)getMonthWeekday:(CFGregorianDate)date;


@end

@interface CTUtility(RandomColor)
+(UIColor *) randomColor;
@end


@interface CTUtility(Others)//其他

+(void)alertMessage:(NSString *)title message:(NSString *)message;
+(void)alertMessage:(NSString *)title
            message:(NSString *)message
           delegate:(id)delegate
  cancelButtonTitle:(NSString *)cancelButton
  otherButtonTitles:(NSString *)otherButton
                tag:(NSInteger)tag;
//拨打电话
+(void)callNumber:(NSString *)phoneNumber;
@end




