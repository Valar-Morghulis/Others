//
//  HexColorString+UIColor.h
//  ShoppingMall
//
//  Created by MaYing on 13-11-23.
//
//

#import <Foundation/Foundation.h>

@interface NSString(HexColorString_UIColor)
-(UIColor *)getColor;
@end

@interface UIColor(HexColorString_UIColor)
-(NSString*)getHexColorString;
@end