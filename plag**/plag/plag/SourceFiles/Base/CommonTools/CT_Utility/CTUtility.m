//
//  CTUtility.m
//  libTest
//
//  Created by yaoyongping on 12-4-23.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CTUtility.h"
#import "RegexKitLite.h"

#import "CTUDIDTools.h"


@implementation CTUtility

+(BOOL)IsExistFileWithName:(NSString *)imagename{
    NSFileManager *fm=[NSFileManager defaultManager];
	NSString *url=[self getCachePath];
	url=[url stringByAppendingPathComponent:APP_CACHE_FOLDER];
	url=[url stringByAppendingPathComponent:imagename];
    //NSError *error;
    if ([fm fileExistsAtPath:url]) {
        return YES;
    }else {
        return NO;
    }
}

+(BOOL)CachImageWithName:(NSString *)imagename img:(UIImage *)img;
{
    NSFileManager *fm=[NSFileManager defaultManager];
    NSError *error;
	NSString *url=[self getCachePath];
	url=[url stringByAppendingPathComponent:APP_CACHE_FOLDER];
    if (![fm fileExistsAtPath:url]) {
        [fm createDirectoryAtPath:url withIntermediateDirectories:YES attributes:nil error:&error];
    }
	url=[url stringByAppendingPathComponent:imagename];
    
    return [UIImagePNGRepresentation(img) writeToFile:url atomically:YES];
}

+(NSString *)imageNameFromUrl:(NSString *)url{
    NSString *imageName=[url lastPathComponent];
    return imageName;
}

+(UIImage *)getCacheImageWithImageName:(NSString *)imagename{
	NSString *url=[self getCachePath];
	url=[url stringByAppendingPathComponent:APP_CACHE_FOLDER];
	url=[url stringByAppendingPathComponent:imagename];
	UIImage *img= [[UIImage alloc] initWithContentsOfFile:url];
	
	return [img autorelease];
}

+(NSString *)getCachePath{
    NSString *url=[@"~" stringByExpandingTildeInPath];
    url=[url stringByAppendingPathComponent:@"Library"];
    url=[url stringByAppendingPathComponent:@"Caches"];
    //NSLog(@"Cache image url=%@",url);
    return url;
}


+(void)clearCachData{
	NSString *url=[@"~" stringByExpandingTildeInPath];
    url=[url stringByAppendingPathComponent:@"Library"];
    url=[url stringByAppendingPathComponent:@"Caches"];
	url=[url stringByAppendingPathComponent:APP_CACHE_FOLDER];
    NSError *error;
    NSFileManager *fm=[NSFileManager defaultManager];
    [fm removeItemAtPath:url error:&error];
	
    [fm createDirectoryAtPath:url withIntermediateDirectories:YES attributes:nil error:&error];
    
}

+(NSString *)pathForImageName:(NSString *)fileName
{
    NSFileManager *fm=[NSFileManager defaultManager];
    NSError *error;
	NSString *url = [self getCachePath];
	url = [url stringByAppendingPathComponent:APP_CACHE_FOLDER];
    if (![fm fileExistsAtPath:url])
    {
        [fm createDirectoryAtPath:url withIntermediateDirectories:YES attributes:nil error:&error];
    }
	url = [url stringByAppendingPathComponent:fileName];
    return url;
}


+(BOOL)CachFileWithPath:(NSString *)fileName dicData:(NSDictionary *)dic
{
    NSFileManager *fm=[NSFileManager defaultManager];
    NSError *error;
	NSString *url=[@"~" stringByExpandingTildeInPath];
	url=[url stringByAppendingPathComponent:APP_CACHE_FOLDER];
    if (![fm fileExistsAtPath:url]) {
        [fm createDirectoryAtPath:url withIntermediateDirectories:YES attributes:nil error:&error];
    }
    NSString* path = [NSString stringWithFormat:@"%@/%@", url, fileName];
    return [dic writeToFile:path atomically:YES];
    
}
+(NSString *)CalLastTime:(NSString *)inputDate{
	NSDate *currentDate=[NSDate date];
	
	NSDateFormatter *dateFormat=[[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	NSDate *toDate=[dateFormat dateFromString:inputDate];
	[dateFormat release];
	
	NSCalendar *cal =[NSCalendar currentCalendar]; 
	unsigned int unitFlags = NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
	NSDateComponents *d = [cal components:unitFlags fromDate:currentDate toDate:toDate options:0];
	NSString *result;
	if ([d day]<0 || [d hour]<0 || [d minute]<0 || [d second]<0) {
		result=@"已过期";
	}else {
		result=[NSString stringWithFormat:@"%d天%d时%d分%d秒",[d day],[d hour],[d minute],[d second]];
	}
	return result;
}

+(NSString *)GetTwitterTime:(NSString *)inputDate{
	NSDate *currentDate=[NSDate date]; 
	NSDateFormatter *dateFormat=[[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	NSDate *fromDate=[dateFormat dateFromString:inputDate];
	[dateFormat release];
	NSCalendar *cal=[NSCalendar currentCalendar];
	unsigned int unitFlags=NSHourCalendarUnit | NSMinuteCalendarUnit;
	NSDateComponents *d=[cal components:unitFlags fromDate:fromDate toDate:currentDate options:0];
	NSString *result;
	int minute=[d minute];
	int hour=[d hour];
	if (hour>24) {
		return inputDate;
	}else {
		if (hour<1) {
			result=[NSString stringWithFormat:@"%d分钟前",minute];
		}else {
			result=[NSString stringWithFormat:@"%d小时前",hour];
		}
		
		return result;
	}
	
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

+(NSString *)FormatDateByString:(NSString *)inputDate{
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

+(NSString *)FormatDigitDateToStringDate:(NSString *)inputDate
{
    NSRange range = [inputDate rangeOfString:@"/"];
    NSRange dateRange = NSMakeRange(0, range.location);
    NSUInteger loc = range.location+range.length;
    NSUInteger len = [inputDate length] - loc;
    NSRange monRange = NSMakeRange(loc,len);
    
    NSString* str = [NSString stringWithFormat:@"%@月%@日", [inputDate substringWithRange:monRange], [inputDate substringWithRange:dateRange]];
    
    //NSLog(@"str:%@", str);
    return  str;
    
}

+(CFGregorianDate)ConvertToCFGregorianDateFromNDate:(NSDate *)date{
	CFGregorianDate result;
	NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date];
	result.year=[comp1 year];
	result.month=[comp1 month];
	result.day=[comp1 day];
	
	return result;
}

+(NSDate *)ConvertToDateFromString:(NSString *)inputDate{
	NSDateFormatter *dateFormat=[[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	NSDate *date=[dateFormat dateFromString:inputDate];
	[dateFormat release];
	
	return date;
}

+(NSDate *)ConvertToDateFromString:(NSString *)inputDate withformat:(NSString *)format{
	NSDateFormatter *dateFormat=[[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:format];
	NSDate *date=[dateFormat dateFromString:inputDate];
	[dateFormat release];
	
	return date;
}

+(NSString *)ConvertToStringFromNSDate:(NSDate *)inpuDate{
	NSDateFormatter *dateFormat=[[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	NSString *result=[dateFormat stringFromDate:inpuDate];
	[dateFormat release];
	return result;
}

+(NSString *)ConvertToStringFromNSDate:(NSDate *)inpuDate withDataFormate:(NSString *)Formate
{
	NSDateFormatter *dateFormat=[[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:Formate];
	NSString *result=[dateFormat stringFromDate:inpuDate];
	[dateFormat release];
	return result;
}


+(NSString *)GetDayFromData:(NSDate *)date
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
+(NSString *)GetWeekFromData:(NSDate *)date
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

+(BOOL)CompareDate:(NSDate *)Date_1 withDate:(NSDate *)Date_2
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
	comps = [calendar components:unitFlags fromDate:Date_1];
	
	int m_year_1 = [comps year];
	//int m_month_1 = [comps month];
	int m_day_1 = [comps day];
	
	comps = [calendar components:unitFlags fromDate:Date_2];
	
	int m_year_2 = [comps year];
	//int m_month_2 = [comps month];
	int m_day_2 = [comps day];
	
	if (m_year_1==m_year_2&&m_day_1==m_day_2)
	{
		return YES;
	}
	else 
	{
		return NO;
	}
	
}

+ (BOOL)checkPhoneValidate:(NSString*)str
{
    NSString *regEx = @"^\\s$";
    NSLog(@"[str length]=%d",[str length]);
    if (str == nil || [str length] != 11) {
        return NO;
    }
    
    regEx = @"^[0-9]*$";
    
    if (![str isMatchedByRegex:regEx]) {
        return NO;
    }
    
    return YES;
}

+ (CTCheckPasswordResultType)checkPassWordValidate:(NSString*)str
{
    NSString *regEx = @"^\\s$";
    
    if (str == nil || [str length] == 0 || [str isMatchedByRegex:regEx]) {
        return CTCheckPasswordResultTypeNull;
    }
    
    if([str length] < 6 || [str length] > 12)
        {
        return CTCheckPasswordResultTypeLength;        
        }
    
    regEx = @"^[A-Z0-9a-z]*$";
    
    if (![str isMatchedByRegex:regEx]) {
        return CTCheckPasswordResultTypeFormat;
    }
    
    return CTCheckPasswordResultTypeSuccess;
}


+(BOOL)IsFloat:(NSString *)string{
	NSScanner *scan=[NSScanner scannerWithString:string];
	float val;
	return [scan scanFloat:&val] && [scan isAtEnd];
}

+(NSString *)Trim:(NSString *)string{
	return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+(BOOL)IsValidateEmail:(NSString *)email{
	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
	
    return [emailTest evaluateWithObject:email];
}

+(float)ComputeDiscount:(float)originalPrice GroupOnPrice:(float)GroupOnPrice{
	float value=(originalPrice-GroupOnPrice)/originalPrice;
	
	return [[[NSString alloc] initWithFormat:@"%.1f",(1-value)*10] floatValue];
}

+(void)CallNumber:(NSString *)phoneNumber{
	NSURL *telUrl=[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNumber]];
	[[UIApplication sharedApplication] openURL:telUrl];
	[phoneNumber release];
}

+(CATransition *)GetTransiton:(CTATransitionType)transactionType direction:(NSString *)direction{
	CATransition *transaction=[CATransition animation];
	transaction.duration=1.0f;
	transaction.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	switch (transactionType) {
		case CTATransitionTypeCube:
			transaction.type=@"cube";
			break;
		case CTATransitionTypeMoveIn:
			
			transaction.type=@"moveIn";
			break;
		case CTATransitionTypeReveal:
			transaction.type=@"reveal";
			break;
		case CTATransitionTypeFade:
			transaction.type=@"fade";
			break;
		case CTATransitionTypePageCurl:
			transaction.type=@"pageCurl";
			break;
		case CTATransitionTypePageUnCurl:
			transaction.type=@"pageUnCurl";
			break;
		case CTATransitionTypeSuckEffect:
			transaction.type=@"suckEffect";
			break;
		case CTATransitionTypeRippleEffect:
			transaction.type=@"rippleEffect";
			break;
		case CTATransitionTypeOglFlip:
			transaction.type=@"oglFlip";
			break;
		case CTATransitionTypeTwist:
			transaction.type=@"twist";
			break;
		default:
			break;
	}
	
	transaction.subtype=direction;
	return transaction;
}
+(CGSize)GetSizeByText:(NSString *)text sizeOfFont:(int)sizeOfFont{
	CGSize size;
	if (text==nil || [text length]==0) {
		size=CGSizeMake(320, 20);
		return size;
	}
	UIFont *font;
	if (sizeOfFont<=0) {
		font=[UIFont systemFontOfSize:12];
	}else {
		font=[UIFont systemFontOfSize:sizeOfFont];
	}
	
	
	size=[text sizeWithFont:font constrainedToSize:CGSizeMake(300.0f,MAXFLOAT) lineBreakMode:UILineBreakModeCharacterWrap];
	return size;
}

+(CGSize)GetSizeByText:(NSString *)text sizeOfFont:(int)sizeOfFont width:(int)width{
	CGSize size;
	if (text==nil || [text length]==0) {
		size=CGSizeMake(320, 20);
		return size;
	}
	UIFont *font;
	if (sizeOfFont<=0) {
		font=[UIFont boldSystemFontOfSize:12];
	}else {
		font=[UIFont boldSystemFontOfSize:sizeOfFont];
	}
	
	
	size=[text sizeWithFont:font constrainedToSize:CGSizeMake(width,MAXFLOAT) lineBreakMode:UILineBreakModeCharacterWrap];
	return size;
}

+(CGSize)GetSizeByText:(NSString *)text sizeOfFont:(int)sizeOfFont height:(int)height{
	CGSize size;
	if (text==nil || [text length]==0) {
		size=CGSizeMake(320, 20);
		return size;
	}
	UIFont *font;
	if (sizeOfFont<=0) {
		font=[UIFont boldSystemFontOfSize:12];
	}else {
		font=[UIFont boldSystemFontOfSize:sizeOfFont];
	}
	
	
	size=[text sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT,height) lineBreakMode:UILineBreakModeCharacterWrap];
	return size;
}

+ (NSString *)getIMEI
{
    return @"358148045937138";
}

+ (NSString *)getIMSI
{
    return @"460002950531203";
}

+ (NSString *)getGUID 
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    NSMakeCollectable(theUUID);
    NSMutableString* str = [[[NSMutableString alloc] initWithString:(NSString *)string] autorelease];
    
    CFRelease(theUUID);
    CFRelease(string);
    
    //NSLog(@"generateNonce = %@", str);    
    
    [str deleteCharactersInRange:NSMakeRange(13,1)];
    
    [str deleteCharactersInRange:NSMakeRange(8,1)];    
    
    //NSLog(@"generateNonce = %@", str);
    return str;
}

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

+ (NSString*)HandleSpecialCharactor:(NSString*)str
{
    NSMutableString* str2 = [[NSMutableString alloc] initWithString:str];  
    
    [str2 replaceOccurrencesOfString:@"\\" withString:@"\\\\" options:NSLiteralSearch range:NSMakeRange(0, [str2 length])];
    
    [str2 replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSLiteralSearch range:NSMakeRange(0, [str2 length])];
    [str2 replaceOccurrencesOfString:@"\t" withString:@"\\t" options:NSLiteralSearch range:NSMakeRange(0, [str2 length])];
    [str2 replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSLiteralSearch range:NSMakeRange(0, [str2 length])];    
    
    return [str2 autorelease];
    
}

+ (NSString*)URLEncodeAndHandleSpecialCharactor:(NSString*)str
{
    NSString* str2 = [self HandleSpecialCharactor:str];
    return [self URLEncode:str2];
}

+(NSString *)GetMoneyStringFormat:(double)f withSymbol:(BOOL)symbol isFloat:(int)count{
	NSMutableString* str =[NSMutableString stringWithFormat:@"%.2f",f];
	
    NSRange dotRange = [str rangeOfString:@"."];
    int dotPos = dotRange.location;
    int startPos = dotPos%3;
    int pos = dotPos-3;
	if (dotRange.length==0) {
		pos=[str length];
	}
    int n = 0;
    while (pos>0) {
        if (startPos == 0) {
            startPos = 3;
        }
        [str insertString:@"," atIndex:n*3+startPos];
        n++;
        startPos++;
        pos = pos-3;        
    }
	
	//    int n = f;
	//    int pos = n/1000;
	//    if (pos >= 1) {
	//        int n = 0;
	//        while (pos) {
	//            n++;
	//            pos = pos/10;
	//        }
	//        [str insertString:@"," atIndex:n];
	//    }
    
    if (symbol) {
        [str insertString:@"¥" atIndex:0];
    }
	
	if (count==0) {
		dotRange = [str rangeOfString:@"."];
		dotPos = dotRange.location;
		NSString *result = [str substringToIndex:dotPos];
		return result;
	}
	
    return str;
}

+(NSString*)GetMoneyStringFormat:(double)f withSymbol:(BOOL)symbol
{
    NSMutableString* str = [[NSMutableString alloc] initWithFormat:@"%.2f", f];
    
    NSRange dotRange = [str rangeOfString:@"."];
    int dotPos = dotRange.location;
    int startPos = dotPos%3;
    int pos = dotPos-3;
    int n = 0;
    while (pos>0) {
        if (startPos == 0) {
            startPos = 3;
        }
        [str insertString:@"," atIndex:n*3+startPos];
        n++;
        startPos++;
        pos = pos-3;        
    }
	
	//    int n = f;
	//    int pos = n/1000;
	//    if (pos >= 1) {
	//        int n = 0;
	//        while (pos) {
	//            n++;
	//            pos = pos/10;
	//        }
	//        [str insertString:@"," atIndex:n];
	//    }
    
    if (symbol) {
        [str insertString:@"¥" atIndex:0];
    }
    
    return [str autorelease];
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
    
	//NSString* str2 = [[NSString alloc] initWithFormat:@"%s", digest];
	
	//NSLog(@"%@", str2);
	
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
+(NSString *)getMonthWeekdayString:(int)weekday withIndex:(int)index{
	NSString *week=@"";
	if (index==0) {
		week=@"星期一";
		switch (weekday) {
			case 2:
				week=@"星期二";
				break;
			case 3:
				week=@"星期三";
				break;
			case 4:
				week=@"星期四";
				break;
			case 5:
				week=@"星期五";
				break;
			case 6:
				week=@"星期六";
				break;
			case 7:
				week=@"星期日";
				break;
			default:
				week=@"星期一";
				break;
		}
	}else {
		
	}
	return week;
}

+ (NSString*)maskAccount:(NSString*)str1
{
    
    NSMutableString* str2 = [[NSMutableString alloc] initWithString:str1];
    
    int len = [str1 length];
    
    int n = len/4;
    
    for (int i = 0 ; i < n; i++) {
        [str2 insertString:@" " atIndex:4*(i+1)+i];
    }
    
    NSString* str = [self Trim:str2];
    
    [str2 release];
    
    return str;    
    
        //    return str1;
        //    
        //    NSMutableString* str2 = [[NSMutableString alloc] initWithString:str1];
        //    
        //    NSMutableString* str3 = [[NSMutableString alloc] init];
        //    
        //    int n = [str1 length] - 12;
        //    
        //    if (n > 0) 
        //    {
        //        for (int i = 0; i < n; i++) 
        //        {
        //            [str3 appendString:@"*"];
        //        }
        //        [str2 replaceCharactersInRange:NSMakeRange(8, n) withString:str3];
        //    }
        //    
        //    [str3 release];
        //    
        //    return [str2 autorelease];
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

+ (NSString *)getUUID
{
    return [CTUDIDTools UDID];
/*
    NSUserDefaults *userdefaults=[NSUserDefaults standardUserDefaults];
    
	NSString *uuid=[userdefaults objectForKey:@"uuid"];
    
    if (uuid) {
        NSString* str = [[[NSString alloc] initWithString:uuid] autorelease];
        return str;
    }
    
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    NSMakeCollectable(theUUID);
    NSString* str = [[[NSString alloc] initWithString:(NSString *)string] autorelease];
    
    [userdefaults setObject:str forKey:@"uuid"];
    
    CFRelease(theUUID);
    CFRelease(string);
    
    return str;
 */
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

+ (NSString *)getParameterString:(NSDictionary *)dic
{
	NSMutableArray* arr = [self bubbleSortDictionaryByKeys:dic];
	
	NSMutableString* paraString = [[NSMutableString alloc] init];
	
	for (NSInteger j = 0; j < [arr count]; j++) {		
        NSString* value = [CTUtility URLEncode:[dic objectForKey:[arr objectAtIndex:j]]];
		NSString* temp2 = [NSString stringWithFormat:@"%@=%@&", [arr objectAtIndex:j], value];
		[paraString appendString:temp2];
	}	
	NSString * str = 0;
    if([paraString length] > 0)
    {
        str = [NSString stringWithFormat:@"%@", [paraString substringToIndex:[paraString length] - 1]];
    }
    
    
    [paraString release];
    
	return str;
}

+ (NSMutableArray *)bubbleSortDictionaryByKeys:(NSDictionary *)dict
{
        //this method takes an NSDictionary and performs a basic bubblesort
        //on its keys. It then returns those ordered keys as an NSMutableArray.
        //You can then traverse the original NSDictionary and retrive its
        //ordered objects by simply stepping through each key in the NSMutableArray.
	
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

+(UIImage *)convertImage:(UIImage *)image  withImageWidth:(float)targetWidth{
    if (targetWidth==0) {
        targetWidth=640;
    }
    UIImage *sourceImage = image;
    CGSize imageSize = sourceImage.size;
    CGSize targetSize;
//    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight =0;
    if (imageSize.width<=targetWidth) {
        return image;
    }else {
        targetHeight=targetWidth*imageSize.height/image.size.width;
    }
    targetSize=CGSizeMake(targetWidth, targetHeight);
    UIImage *newImage = nil;      
    
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
        {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
            // center the image
        if (widthFactor > heightFactor)
            {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.4;
            }
        else
            if (widthFactor < heightFactor)
                {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.4;
                }
        }      
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
        //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

@end


