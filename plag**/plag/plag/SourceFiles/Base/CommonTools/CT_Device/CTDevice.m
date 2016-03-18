

#import "CTDevice.h"

#import <sys/utsname.h>

@implementation CTDevice
+(CTDeviceType)deviceType
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    CTDeviceType res = CTDeviceTypeOther;
    
    if ([deviceString isEqualToString:@"iPhone1,1"])
        res = CTDeviceTypeIPhone1G;
    else if ([deviceString isEqualToString:@"iPhone1,2"])
        res = CTDeviceTypeIPhone3G;
    else if ([deviceString isEqualToString:@"iPhone2,1"])
        res = CTDeviceTypeIPhone3GS;
    else if ([deviceString isEqualToString:@"iPhone3,1"])
        res = CTDeviceTypeIPhone4;
    else if ([deviceString isEqualToString:@"iPhone4,1"])
        res = CTDeviceTypeIPhone4S;
    else if ([deviceString isEqualToString:@"iPhone3,2"])
        res = CTDeviceTypeVerizonIPhone4;
    else if ([deviceString isEqualToString:@"iPod1,1"])
        res = CTDeviceTypeIPodTouch1G;
    else if ([deviceString isEqualToString:@"iPod2,1"])
        res = CTDeviceTypeIPodTouch2G;
    else if ([deviceString isEqualToString:@"iPod3,1"])
        res = CTDeviceTypeIPodTouch3G;
    else if ([deviceString isEqualToString:@"iPod4,1"])
        res = CTDeviceTypeIPodTouch4G;
    else if ([deviceString isEqualToString:@"iPad1,1"])
        res = CTDeviceTypeIPad;
    else if ([deviceString isEqualToString:@"iPad2,1"])
        res = CTDeviceTypeIPad2WiFi;
    else if ([deviceString isEqualToString:@"iPad2,2"])
        res = CTDeviceTypeIPad2GSM;
    else if ([deviceString isEqualToString:@"iPad2,3"])
        res = CTDeviceTypeIPad2CDMA;
    else if ([deviceString isEqualToString:@"i386"])
        res = CTDeviceTypeSimulator;
    else if ([deviceString isEqualToString:@"x86_64"])
        res = CTDeviceTypeSimulator;
    
    return res;

}
+(CGRect)deviceFrame
{
    return [ UIScreen mainScreen ].applicationFrame;
}
+(CGSize)deviceSize
{
    return [ UIScreen mainScreen ].applicationFrame.size;
}
+(CGSize)deviceBoundSize
{
    return [ UIScreen mainScreen ].bounds.size;
}
+(BOOL)isIphone5
{
    return CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size);
}
+(BOOL)isIphone5OrLater
{
    CGSize size = [[UIScreen mainScreen] currentMode].size;
    return (size.width >= 640 && size.height >= 1136);
}
+(int)windowRootHeight
{
    return [CTDevice deviceSize].height-20-90;
    //    if ([CTDevice isIphone5])
    //        return 458;
    //    else
    //        return 370;
}

+(int)windowHeight
{
    return [CTDevice deviceSize].height-20-44;
    
    //    if ([device isIphone5])
    //        return 504;
    //    else
    //        return 416;
}
+(int)boundHeihgt
{
    return [UIScreen mainScreen ].bounds.size.height;
}

+(int)deviceHeight
{
    return [UIScreen mainScreen ].bounds.size.height - 20;
}
+ (NSString*)deviceString
{
    NSString * res = 0;
    CTDeviceType type = [CTDevice deviceType];
    switch (type)
    {
        case CTDeviceTypeIPhone1G:
            res = @"iPhone 1G";
            break;
        case CTDeviceTypeIPhone3G:
            res = @"iPhone 3G";
            break;
        case CTDeviceTypeIPhone3GS:
            res = @"iPhone 3GS";
            break;
        case CTDeviceTypeIPhone4:
            res = @"iPhone 4";
            break;
        case CTDeviceTypeIPhone4S:
            res = @"iPhone 4S";
            break;
        case CTDeviceTypeVerizonIPhone4:
            res = @"Verizon iPhone 4";
            break;
        case CTDeviceTypeIPodTouch1G:
            res = @"iPod Touch 1G";
            break;
        case CTDeviceTypeIPodTouch2G:
            res = @"iPod Touch 2G";
            break;
        case CTDeviceTypeIPodTouch3G:
            res = @"iPod Touch 3G";
            break;
        case CTDeviceTypeIPodTouch4G:
            res = @"iPod Touch 4G";
            break;
        case CTDeviceTypeIPad:
            res = @"iPad";
            break;
        case CTDeviceTypeIPad2WiFi:
            res = @"iPad 2 (WiFi)";
            break; case CTDeviceTypeIPad2GSM:
            res = @"iPad 2 (GSM)";
            break;
        case CTDeviceTypeIPad2CDMA:
            res = @"iPad 2 (CDMA)";
            break;
        case CTDeviceTypeSimulator:
            res = @"Simulator";
            break;
        case CTDeviceTypeOther:
            res = @"Other";
            break;
        default:
            break;
    }
    return res;
}

@end

