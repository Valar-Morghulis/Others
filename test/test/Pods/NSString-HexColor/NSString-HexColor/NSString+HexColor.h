//
//  NSString+HexColor.h
//  ShoppingMall
//
//  Created by MaYing on 13-11-23.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString(HexColor)
-(UIColor *)getColor;
@end

@interface UIColor(HexString)
-(NSString*)getHexColorString;
@end