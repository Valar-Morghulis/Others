

#import "CTDevice.h"

#import <sys/utsname.h>

@implementation CTDevice
+(CTDeviceType)deviceType
{
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone1,1"]) return CTDeviceTypeIPhone2G;// @"iPhone 2G (A1203)"
    if ([deviceString isEqualToString:@"iPhone1,2"]) return CTDeviceTypeIPhone3G;//@"iPhone 3G (A1241/A1324)";
    if ([deviceString isEqualToString:@"iPhone2,1"]) return CTDeviceTypeIPhone3GS;//@"iPhone 3GS (A1303/A1325)";
    if ([deviceString isEqualToString:@"iPhone3,1"]) return CTDeviceTypeIPhone4;//@"iPhone 4 (A1332)";
    if ([deviceString isEqualToString:@"iPhone3,2"]) return CTDeviceTypeIPhone4;//@"iPhone 4 (A1332)";
    if ([deviceString isEqualToString:@"iPhone3,3"]) return CTDeviceTypeIPhone4;//@"iPhone 4 (A1349)";
    if ([deviceString isEqualToString:@"iPhone4,1"]) return CTDeviceTypeIPhone4S;//@"iPhone 4S (A1387/A1431)";
    if ([deviceString isEqualToString:@"iPhone5,1"]) return CTDeviceTypeIPhone5;//@"iPhone 5 (A1428)";
    if ([deviceString isEqualToString:@"iPhone5,2"]) return CTDeviceTypeIPhone5;//@"iPhone 5 (A1429/A1442)";
    if ([deviceString isEqualToString:@"iPhone5,3"]) return CTDeviceTypeIPhone5C;//@"iPhone 5c (A1456/A1532)";
    if ([deviceString isEqualToString:@"iPhone5,4"]) return CTDeviceTypeIPhone5C;//@"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([deviceString isEqualToString:@"iPhone6,1"]) return CTDeviceTypeIPhone5S;//@"iPhone 5s (A1453/A1533)";
    if ([deviceString isEqualToString:@"iPhone6,2"]) return CTDeviceTypeIPhone5S;//@"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([deviceString isEqualToString:@"iPhone7,1"]) return CTDeviceTypeIPhone6Plus;//@"iPhone 6 Plus (A1522/A1524)";
    if ([deviceString isEqualToString:@"iPhone7,2"]) return CTDeviceTypeIPhone6;//@"iPhone 6 (A1549/A1586)";
    
    if ([deviceString isEqualToString:@"iPod1,1"])   return CTDeviceTypeIPodTouch1G;//@"iPod Touch 1G (A1213)";
    if ([deviceString isEqualToString:@"iPod2,1"])   return CTDeviceTypeIPodTouch2G;//@"iPod Touch 2G (A1288)";
    if ([deviceString isEqualToString:@"iPod3,1"])   return CTDeviceTypeIPodTouch3G;//@"iPod Touch 3G (A1318)";
    if ([deviceString isEqualToString:@"iPod4,1"])   return CTDeviceTypeIPodTouch4G;//@"iPod Touch 4G (A1367)";
    if ([deviceString isEqualToString:@"iPod5,1"])   return CTDeviceTypeIPodTouch5G;//@"iPod Touch 5G (A1421/A1509)";
    
    if ([deviceString isEqualToString:@"iPad1,1"])   return CTDeviceTypeIPad1G;//@"iPad 1G (A1219/A1337)";
    if ([deviceString isEqualToString:@"iPad2,1"])   return CTDeviceTypeIPad2;//@"iPad 2 (A1395)";
    if ([deviceString isEqualToString:@"iPad2,2"])   return CTDeviceTypeIPad2;//@"iPad 2 (A1396)";
    if ([deviceString isEqualToString:@"iPad2,3"])   return CTDeviceTypeIPad2;//@"iPad 2 (A1397)";
    if ([deviceString isEqualToString:@"iPad2,4"])   return CTDeviceTypeIPad2;//@"iPad 2 (A1395+New Chip)";
    if ([deviceString isEqualToString:@"iPad2,5"])   return CTDeviceTypeIPadMini1G;//@"iPad Mini 1G (A1432)";
    if ([deviceString isEqualToString:@"iPad2,6"])   return CTDeviceTypeIPadMini1G;//@"iPad Mini 1G (A1454)";
    if ([deviceString isEqualToString:@"iPad2,7"])   return CTDeviceTypeIPadMini1G;//@"iPad Mini 1G (A1455)";
    
    if ([deviceString isEqualToString:@"iPad3,1"])   return CTDeviceTypeIPad3;//@"iPad 3 (A1416)";
    if ([deviceString isEqualToString:@"iPad3,2"])   return CTDeviceTypeIPad3;//@"iPad 3 (A1403)";
    if ([deviceString isEqualToString:@"iPad3,3"])   return CTDeviceTypeIPad3;//@"iPad 3 (A1430)";
    if ([deviceString isEqualToString:@"iPad3,4"])   return CTDeviceTypeIPad4;//@"iPad 4 (A1458)";
    if ([deviceString isEqualToString:@"iPad3,5"])   return CTDeviceTypeIPad4;//@"iPad 4 (A1459)";
    if ([deviceString isEqualToString:@"iPad3,6"])   return CTDeviceTypeIPad4;//@"iPad 4 (A1460)";
    
    if ([deviceString isEqualToString:@"iPad4,1"])   return CTDeviceTypeIPadAir;//@"iPad Air (A1474)";
    if ([deviceString isEqualToString:@"iPad4,2"])   return CTDeviceTypeIPadAir;//@"iPad Air (A1475)";
    if ([deviceString isEqualToString:@"iPad4,3"])   return CTDeviceTypeIPadAir;//@"iPad Air (A1476)";
    if ([deviceString isEqualToString:@"iPad4,4"])   return CTDeviceTypeIPadMini2G;//@"iPad Mini 2G (A1489)";
    if ([deviceString isEqualToString:@"iPad4,5"])   return CTDeviceTypeIPadMini2G;//@"iPad Mini 2G (A1490)";
    if ([deviceString isEqualToString:@"iPad4,6"])   return CTDeviceTypeIPadMini2G;//@"iPad Mini 2G (A1491)";
    
    if ([deviceString isEqualToString:@"i386"])      return CTDeviceTypeSimulator_i386;//@"iPhone Simulator";
    if ([deviceString isEqualToString:@"x86_64"])    return CTDeviceTypeSimulator_x86_64;//@"iPhone Simulator";
    
    return CTDeviceTypeOthers;

}

+(BOOL)isIphone5OrLater
{
    CTDeviceType type = [CTDevice deviceType];
    return (type >= CTDeviceTypeIPhone5 && type < CTDeviceTypeIPodTouch1G);
}
+(BOOL)isIOS7OrLater
{
    return ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0);
}

@end

