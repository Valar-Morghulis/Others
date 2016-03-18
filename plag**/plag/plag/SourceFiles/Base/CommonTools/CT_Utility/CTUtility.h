//
//  CTUtility.h
//  libTest
//
//  Created by yaoyongping on 12-4-23.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "APP_GlobeDefine.h"

#import <QuartzCore/QuartzCore.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonDigest.h>
#import "CTAlertView.h"


typedef enum
{
	CTATransitionTypeCube=0,
	CTATransitionTypeMoveIn,
	CTATransitionTypeReveal,
	CTATransitionTypeFade,
	CTATransitionTypePageCurl,
	CTATransitionTypePageUnCurl,
	CTATransitionTypeSuckEffect,
	CTATransitionTypeRippleEffect,
	CTATransitionTypeOglFlip,
	CTATransitionTypeTwist,
} CTATransitionType;

typedef enum {
    CTCheckPasswordResultTypeLength=0,          //密码长度不够
    CTCheckPasswordResultTypeNull,              //密码为空
    CTCheckPasswordResultTypeFormat,            //密码格式不对，只能数字和字母
    CTCheckPasswordResultTypeSuccess,           //验证通过
    
}CTCheckPasswordResultType;

@interface CTUtility : NSObject
{

}

+(BOOL)IsExistFileWithName:(NSString *)imagename;
+(BOOL)CachFileWithPath:(NSString *)fileName dicData:(NSDictionary *)dic;
+(NSString *)imageNameFromUrl:(NSString *)url;
+(BOOL)CachImageWithName:(NSString *)imagename img:(UIImage *)img;
+(UIImage *)getCacheImageWithImageName:(NSString *)imagename;
+(NSString *)getCachePath;
+(void)clearCachData;
+(NSString *)pathForImageName:(NSString *)fileName;

//获取时间差
+(NSString *)CalLastTime:(NSString *)inputDate;

//格式化微博时间
+(NSString *)GetTwitterTime:(NSString *)inputDate;

//判断字符串是否为数字
+(BOOL)IsFloat:(NSString *)string;

//验证手机号码
+ (BOOL)checkPhoneValidate:(NSString*)str;
//验证密码
+ (CTCheckPasswordResultType)checkPassWordValidate:(NSString*)str;

//格式化字符串  将字符串两边空格去掉
+(NSString *)Trim:(NSString *)string;

//验证邮箱地址是否合法
+(BOOL)IsValidateEmail:(NSString *)email;

//通过原始价格和现有价格计算折扣值
+(float)ComputeDiscount:(float)originalPrice GroupOnPrice:(float)GroupOnPrice;

//比较是否为同一天
+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2;

//格式化日期
+(NSString *)FormatDateByString:(NSString *)inputDate;

// 15/10 -> 10月15号
+(NSString *)FormatDigitDateToStringDate:(NSString *)inputDate;

+(CFGregorianDate)ConvertToCFGregorianDateFromNDate:(NSDate *)date;
//将字符串转换为日期
+(NSDate *)ConvertToDateFromString:(NSString *)inputDate;

+(NSDate *)ConvertToDateFromString:(NSString *)inputDate withformat:(NSString *)format;

//将日期转换为字符串格式
+(NSString *)ConvertToStringFromNSDate:(NSDate *)inpuDate;

//将日期转换为字符串格式
+(NSString *)ConvertToStringFromNSDate:(NSDate *)inpuDate withDataFormate:(NSString *)Formate;

//读取day
+(NSString *)GetDayFromData:(NSDate *)date;

//读取week
+(NSString *)GetWeekFromData:(NSDate *)date;

+(BOOL)CompareDate:(NSDate *)Date_1 withDate:(NSDate *)Date_2;

//拨打电话
+(void)CallNumber:(NSString *)phoneNumber; 

//获取翻转效果   
//tarnsactionType参数选择：	@"cube" @"moveIn" @"reveal" @"fade"(default) @"pageCurl" 
//							@"pageUnCurl" @"suckEffect" @"rippleEffect" @"oglFlip" @“twist”
//direction参数选择：			kCATransitionFromRight;kCATransitionFromLeft;kCATransitionFromTop;
//							kCATransitionFromBottom; kCATransitionFade;kCATransitionMoveIn;
//							kCATransitionPush;kCATransitionReveal;
+(CATransition *)GetTransiton:(CTATransitionType)transactionType direction:(NSString *)direction;

//根据文本内容获取文本的size
+(CGSize)GetSizeByText:(NSString *)text sizeOfFont:(int)sizeOfFont;
+(CGSize)GetSizeByText:(NSString *)text sizeOfFont:(int)sizeOfFont width:(int)width;
+(CGSize)GetSizeByText:(NSString *)text sizeOfFont:(int)sizeOfFont height:(int)height;

+ (NSString *)getIMEI;

+ (NSString *)getIMSI;

+ (NSString *)getGUID;

+ (NSString*)MD5Encode:(NSString*)input;
+ (NSString*)URLEncode:(NSString*)str;
+ (NSString*)URLDecoded:(NSString*)str;
+ (NSString*)HandleSpecialCharactor:(NSString*)str;
+ (NSString*)URLEncodeAndHandleSpecialCharactor:(NSString*)str;

+(NSString*)GetMoneyStringFormat:(double)f withSymbol:(BOOL)symbol;
+(NSString *)GetMoneyStringFormat:(double)f withSymbol:(BOOL)symbol isFloat:(int)count;
+ (NSString *)base64StringWithHMACSHA1Digest:(NSString *)strSource key:(NSString *)secretKey;
+ (NSString *)base64StringFromData:(NSData *)data length:(int)length;

+(int)getMonthWeekday:(CFGregorianDate)date;
+(NSString *)getMonthWeekdayString:(int)weekday withIndex:(int)index;

+ (NSString*)maskAccount:(NSString*)str1;
+ (NSString*)sha1:(NSString*)input;

+(void)alertMessage:(NSString *)title message:(NSString *)message;
+(void)alertMessage:(NSString *)title 
            message:(NSString *)message 
           delegate:(id)delegate 
  cancelButtonTitle:(NSString *)cancelButton
  otherButtonTitles:(NSString *)otherButton
                tag:(NSInteger)tag;

+ (NSString *)getUUID;
+ (NSString *)generateTimestamp;
+ (NSString *)generateNonce;
+ (NSString *)getParameterString:(NSDictionary *)dic;
+ (NSMutableArray *)bubbleSortDictionaryByKeys:(NSDictionary *)dict;
+(UIImage *)convertImage:(UIImage *)image withImageWidth:(float)targetWidth;
@end
