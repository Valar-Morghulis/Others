

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define IS_IPHONE5_OR_LATER       [CTDevice isIphone5OrLater]
#define IS_IPHONE6_OR_LATER       [CTDevice isIphone6OrLater]
#define IS_IOS7_OR_LATER      [CTDevice isIOS7OrLater]


typedef enum CTDeviceType_Enum
{
    CTDeviceTypeSimulator_i386 = 0,
    CTDeviceTypeSimulator_x86_64 = 1,
    
    //iphone
     CTDeviceTypeIPhone2G = 10000,
    CTDeviceTypeIPhone3G,
    CTDeviceTypeIPhone3GS,
    CTDeviceTypeIPhone4,
    CTDeviceTypeIPhone4S,
    CTDeviceTypeIPhone5,
    CTDeviceTypeIPhone5C,
    CTDeviceTypeIPhone5S,
    CTDeviceTypeIPhone6Plus,
    CTDeviceTypeIPhone6,
    CTDeviceTypeIPhone6s,
    CTDeviceTypeIPhone6sPlus,
    //
    CTDeviceTypeIPhoneOthers,
   
    //iPod Touch
    CTDeviceTypeIPodTouch1G = 20000,
    CTDeviceTypeIPodTouch2G,
    CTDeviceTypeIPodTouch3G,
    CTDeviceTypeIPodTouch4G,
    CTDeviceTypeIPodTouch5G,
    //
    CTDeviceTypeIPodOthers,

    //iPad
    CTDeviceTypeIPad1G = 30000,
    CTDeviceTypeIPad2,
    CTDeviceTypeIPadMini1G,
    CTDeviceTypeIPad3,
    CTDeviceTypeIPad4, 
    CTDeviceTypeIPadAir,
    CTDeviceTypeIPadMini2G,
    //
    CTDeviceTypeIPadOthers,
    
    //others
    CTDeviceTypeOthers = 40000,
    
}CTDeviceType;



@interface CTDevice : NSObject

+(CTDeviceType)deviceType;
+(BOOL)isIphone5OrLater;
+(BOOL)isIphone6OrLater;
+(BOOL)isIOS7OrLater;
@end



