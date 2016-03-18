

#import <Foundation/Foundation.h>

#import "APP_GlobeDefine.h"

#define DEVICE_FRAME [CTDevice deviceFrame]
#define DEVICE_SIZE   [CTDevice deviceSize]

#define DEVICE_BOUND_SIZE [CTDevice deviceBoundSize]

#define IS_IPHONE5       [CTDevice isIphone5]
#define IS_IPHONE5_OR_LATER       [CTDevice isIphone5OrLater]
#define BOUND_HEIGHT   [CTDevice boundHeihgt]

#define DEVICE_HEIGHT  [CTDevice deviceHeight]

#define WINDOW_HEIGHT		[CTDevice windowHeight]

#define WINDOW_ROOT_HEIGHT 	[CTDevice windowRootHeight]

#define IS_IOS7_OR_LATER     ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)


typedef enum CTDeviceType_Enum
{
    CTDeviceTypeIPhone1G=0,
    CTDeviceTypeIPhone3G,
    CTDeviceTypeIPhone3GS,
    CTDeviceTypeIPhone4,
    CTDeviceTypeIPhone4S,
    CTDeviceTypeVerizonIPhone4,
    CTDeviceTypeIPodTouch1G,
    CTDeviceTypeIPodTouch2G,
    CTDeviceTypeIPodTouch3G,
    CTDeviceTypeIPodTouch4G,
    CTDeviceTypeIPad,
    CTDeviceTypeIPad2WiFi,
    CTDeviceTypeIPad2GSM,
    CTDeviceTypeIPad2CDMA,
    CTDeviceTypeSimulator,
    CTDeviceTypeOther,
    
}CTDeviceType;



@interface CTDevice : NSObject

+(CTDeviceType)deviceType;
+(CGRect) deviceFrame;
+(CGSize)deviceSize;
+(CGSize)deviceBoundSize;
+(BOOL)isIphone5;
+(int)windowRootHeight;
+(int)windowHeight;
+(int)boundHeihgt;
+(int)deviceHeight;
+ (NSString*)deviceString;
+(BOOL)isIphone5OrLater;
@end



