//
//  NSString+HexColor.m
//  ShoppingMall
//
//  Created by MaYing on 13-11-23.
//
//

#import "NSString+HexColor.h"

@implementation NSString(HexColor)
-(UIColor *)getColor
{
    NSString * hexColorString = self;
    unsigned long long hexColorValue = 0;
    [[NSScanner scannerWithString:hexColorString] scanHexLongLong:&hexColorValue];
    
    int r = (hexColorValue & 0xFF0000 )>>16;
    int g = (hexColorValue & 0x00FF00 )>>8;
    int b =  hexColorValue & 0x0000FF;
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}
@end

@implementation UIColor(HexString)
-(NSString*)getHexColorString
{
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    int r = components[0] * 255.0;
    int g = components[1] * 255.0;
    int b = components[2] * 255.0;
    unsigned long hexValue = r << 16 | g << 8 | b;
    char hexColorBuff[20];
    sprintf(hexColorBuff, "%06lx",hexValue);
    return [NSString stringWithFormat:@"%s",hexColorBuff];
}
@end