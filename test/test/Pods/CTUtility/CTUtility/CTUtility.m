//
//  CTUtility.m
//  libTest
//
//  Created by yaoyongping on 12-4-23.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CTUtility.h"

NSString * APP_CACHE_FOLDER = @"appCache";

@implementation CTUtility

@end

@implementation CTUtility(Parameters)
+ (NSString *)getGUID
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    NSMakeCollectable(theUUID);
    NSMutableString* str = [[[NSMutableString alloc] initWithString:(NSString *)string] autorelease];
    
    CFRelease(theUUID);
    CFRelease(string);
    
    //[str deleteCharactersInRange:NSMakeRange(13,1)];
    //[str deleteCharactersInRange:NSMakeRange(8,1)];
    
    return str;
}
+(NSString *)getUDID
{
    return [[NSUUID UUID] UUIDString];
}
+(NSString *)getUDIDWidthKeyChain
{
    NSString * key = @"getUDIDWidthKeyChain";
    NSString *uuid = [[A0SimpleKeychain keychain] stringForKey:key];
    if(!uuid)
    {
        uuid = [CTUtility getUDID];
        [[A0SimpleKeychain keychain] setString:uuid forKey:key];
    }
    return uuid;
}
+(NSString *)getMacIdentifier
{
    return [UIDevice currentDevice].uniqueDeviceIdentifier;
}
+ (NSString *)generateTimestamp
{
    return [[[NSString alloc] initWithFormat:@"%ld", time(NULL)] autorelease];
}

+ (NSString *)generateNonce
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    NSMakeCollectable(theUUID);
    NSMutableString* str = [[[NSMutableString alloc] initWithString:(NSString *)string] autorelease];
    
    [str deleteCharactersInRange:NSMakeRange(13,1)];
    
    [str deleteCharactersInRange:NSMakeRange(8,1)];
    
    CFRelease(theUUID);
    CFRelease(string);
    
    return str;
}

@end

@implementation CTUtility(Encode_Decode)
+ (NSString*)MD5Encode:(NSString*)input
{
    if (!input) {
        return @"";
    }
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}





+ (NSString*)URLEncode:(NSString*)str
{
    return [(NSString *) CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)[[str mutableCopy] autorelease], NULL, CFSTR("￼=,!$&'()*+;@?\n\"<>#\t :/~"),kCFStringEncodingUTF8) autorelease];
}

+ (NSString*)URLDecoded:(NSString*)str
{
    NSString *result = (NSString *)
    CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                            (CFStringRef)str,
                                                            CFSTR(""),
                                                            kCFStringEncodingUTF8);
    [result autorelease];
    return result;
}


static char base64EncodingTable[64] = {
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
    'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
    'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
    'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
};

+ (NSString *)base64StringWithHMACSHA1Digest:(NSString *)strSource key:(NSString *)secretKey
{
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    
    char *keyCharPtr = strdup([secretKey UTF8String]);
    char *dataCharPtr = strdup([strSource UTF8String]);
    
    CCHmacContext hctx;
    CCHmacInit(&hctx, kCCHmacAlgSHA1, keyCharPtr, strlen(keyCharPtr));
    CCHmacUpdate(&hctx, dataCharPtr, strlen(dataCharPtr));
    CCHmacFinal(&hctx, digest);
    
    NSData *encryptedStringData = [NSData dataWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
    
    free(keyCharPtr);
    free(dataCharPtr);
    
    return [CTUtility base64StringFromData:encryptedStringData length:[encryptedStringData length]];
}

+ (NSString *)base64StringFromData:(NSData *)data length:(int)length
{
    unsigned long ixtext, lentext;
    long ctremaining;
    unsigned char input[3], output[4];
    short i, charsonline = 0, ctcopy;
    const unsigned char *raw;
    NSMutableString *result;
    
    lentext = [data length];
    if (lentext < 1)
        return @"";
    result = [NSMutableString stringWithCapacity: lentext];
    raw = [data bytes];
    ixtext = 0;
    
    while (true) {
        ctremaining = lentext - ixtext;
        if (ctremaining <= 0)
            break;
        for (i = 0; i < 3; i++) {
            unsigned long ix = ixtext + i;
            if (ix < lentext)
                input[i] = raw[ix];
            else
                input[i] = 0;
        }
        output[0] = (input[0] & 0xFC) >> 2;
        output[1] = ((input[0] & 0x03) << 4) | ((input[1] & 0xF0) >> 4);
        output[2] = ((input[1] & 0x0F) << 2) | ((input[2] & 0xC0) >> 6);
        output[3] = input[2] & 0x3F;
        ctcopy = 4;
        
        switch (ctremaining) {
            case 1:
                ctcopy = 2;
                break;
            case 2:
                ctcopy = 3;
                break;
        }
        
        for (i = 0; i < ctcopy; i++)
            [result appendString: [NSString stringWithFormat: @"%c", base64EncodingTable[output[i]]]];
        
        for (i = ctcopy; i < 4; i++)
            [result appendString: @"="];
        
        ixtext += 3;
        charsonline += 4;
        
        if ((length > 0) && (charsonline >= length))
            charsonline = 0;
    }
    
    return result;
}
+ (NSString*)sha1:(NSString*)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

@end

@implementation CTUtility(Cache)

+(BOOL)isFileExist:(NSString *)fileName
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *url = [self getCachePath];
    url = [url stringByAppendingPathComponent:fileName];
    return [fm fileExistsAtPath:url];
}

+(BOOL)cacheImageWithName:(NSString *)imageName image:(UIImage *)image
{
    NSString * url = [self getCachePath];
    url = [url stringByAppendingPathComponent:imageName];
    return [UIImagePNGRepresentation(image) writeToFile:url atomically:YES];
}


+(UIImage *)getCacheImageWithImageName:(NSString *)imagename{
    NSString *url = [self getCachePath];
    url=[url stringByAppendingPathComponent:imagename];
    UIImage *img= [[UIImage alloc] initWithContentsOfFile:url];
    return [img autorelease];
}

+(NSString *)getCachePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *url = [paths objectAtIndex:0];
    url = [url stringByAppendingPathComponent:APP_CACHE_FOLDER];
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:url])
    {
        [fm createDirectoryAtPath:url withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return url;
}


+(void)clearCachData
{
    NSString *url = [CTUtility getCachePath];
    NSError *error;
    NSFileManager *fm = [NSFileManager defaultManager];
    [fm removeItemAtPath:url error:&error];
    [fm createDirectoryAtPath:url withIntermediateDirectories:YES attributes:nil error:&error];
    
}

+(NSString *)pathForFileName:(NSString *)fileName
{
    NSString *url = [self getCachePath];
    url = [url stringByAppendingPathComponent:fileName];
    return url;
}


+(BOOL)cacheFileWidthData:(NSString *)fileName dicData:(NSDictionary *)dic
{
    NSString *url = [self getCachePath];
    url = [url stringByAppendingPathComponent:fileName];
    return [dic writeToFile:url atomically:YES];
    
}
@end

@implementation CTUtility(Check)

+(BOOL)isFloat:(NSString *)string
{
    NSScanner *scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

+(NSString *)trim:(NSString *)string
{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}


+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}


@end


@implementation CTUtility(Format)
+ (NSMutableArray *)bubbleSortDictionaryByKeys:(NSDictionary *)dict
{
    
    if(!dict)
        return nil;
    NSMutableArray *sortedKeys = [NSMutableArray arrayWithArray: [dict allKeys]];
    if([sortedKeys count] <= 0)
        return nil;
    else if([sortedKeys count] == 1)
        return sortedKeys; //no sort needed
    
    //perform bubble sort on keys:
    int n = [sortedKeys count] -1;
    int i;
    BOOL swapped = YES;
    
    NSString *key1,*key2;
    NSComparisonResult result;
    
    while(swapped)
    {
        swapped = NO;
        for(i=0;i<n;i++)
        {
            key1 = [sortedKeys objectAtIndex: i];
            key2 = [sortedKeys objectAtIndex: i+1];
            
            //here is where we do our basic NSString comparison
            //This can be easily customized.
            //See the options for -compare: in NSString docs
            result = [key1 compare: key2 ];
            if(result == NSOrderedDescending)
            {
                //we retain for good form, but these
                //objects should still be safely
                //retained by the dictionary:
                [key1 retain];
                [key2 retain];
                
                //pop the two keys out of the array
                [sortedKeys removeObjectAtIndex: i]; // key1
                [sortedKeys removeObjectAtIndex: i]; // key2
                //replace them
                [sortedKeys insertObject: key1 atIndex: i];
                [sortedKeys insertObject: key2 atIndex: i];
                
                [key1 release];
                [key2 release];
                
                swapped = YES;
            }
        }
    }
    
    return sortedKeys;
}

+(NSString *)formatDateByString:(NSString *)inputDate{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormat dateFromString:inputDate];
    [dateFormat release];
    
    NSCalendar *cal=[NSCalendar currentCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *d=[cal components:unitFlags fromDate:date];
    return [NSString stringWithFormat:@"%d年%d月%d日",[d year],[d month],[d day]];
}


+(CFGregorianDate)convertToCFGregorianDateFromNDate:(NSDate *)date{
    CFGregorianDate result;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date];
    result.year=[comp1 year];
    result.month=[comp1 month];
    result.day=[comp1 day];
    
    return result;
}

+(NSDate *)convertToDateFromString:(NSString *)inputDate{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormat dateFromString:inputDate];
    [dateFormat release];
    
    return date;
}

+(NSDate *)convertToDateFromString:(NSString *)inputDate withformat:(NSString *)format{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    NSDate *date=[dateFormat dateFromString:inputDate];
    [dateFormat release];
    
    return date;
}

+(NSString *)convertToStringFromNSDate:(NSDate *)inpuDate{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *result=[dateFormat stringFromDate:inpuDate];
    [dateFormat release];
    return result;
}

+(NSString *)convertToStringFromNSDate:(NSDate *)inpuDate withDataFormate:(NSString *)Formate
{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:Formate];
    NSString *result=[dateFormat stringFromDate:inpuDate];
    [dateFormat release];
    return result;
}


+(NSString *)getDayFromData:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *comps  = [calendar components:unitFlags fromDate:date];
    
    NSString *m_day = [NSString stringWithFormat:@"%d",[comps day]];
    
    [calendar release];
    
    return m_day;
}

//读取week
+(NSString *)getWeekFromData:(NSDate *)date
{
    
    NSDateFormatter *formatter =[[[NSDateFormatter alloc] init] autorelease];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    NSCalendar *calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDateComponents *comps = [[[NSDateComponents alloc] init] autorelease];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    //int week=0;
    comps = [calendar components:unitFlags fromDate:date];
    int week = [comps weekday]; 
    NSString *m_week = [NSString stringWithFormat:@"%d",week];
    return m_week;
}

+(int)getMonthWeekday:(CFGregorianDate)date
{
    CFTimeZoneRef tz = CFTimeZoneCopyDefault();
    CFGregorianDate month_date;
    month_date.year=date.year;
    month_date.month=date.month;
    month_date.day=date.day;
    month_date.hour=0;
    month_date.minute=0;
    month_date.second=1;
    return (int)CFAbsoluteTimeGetDayOfWeek(CFGregorianDateGetAbsoluteTime(month_date,tz),tz);
}

@end
@implementation CTUtility(RandomColor)

+(UIColor *) randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
@end
@implementation CTUtility(Others)

+(void)callNumber:(NSString *)phoneNumber
{
    NSURL *telUrl = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNumber]];
    [[UIApplication sharedApplication] openURL:telUrl];
    [phoneNumber release];
}
+(void)alertMessage:(NSString *)title message:(NSString *)message{
    CTAlertView *alert=[[CTAlertView alloc] initWithTitle:title
                                                  message:message
                                                 delegate:nil
                                        cancelButtonTitle:@"确定"
                                        otherButtonTitles:nil];
    [alert show];
    [alert release];
}


+(void)alertMessage:(NSString *)title
            message:(NSString *)message
           delegate:(id)delegate
  cancelButtonTitle:(NSString *)cancelButton
  otherButtonTitles:(NSString *)otherButton
                tag:(NSInteger)tag
{
    CTAlertView *alert=[[CTAlertView alloc] initWithTitle:title
                                                  message:message
                                                 delegate:delegate
                                        cancelButtonTitle:cancelButton
                                        otherButtonTitles:otherButton,nil];
    alert.tag = tag;
    [alert show];
    [alert release];
}


@end



