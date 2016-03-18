//
//  ScaleAndCropping.h
//  Shopping_Mall
//
//  Created by MaYing on 13-10-6.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage(Tools)

-(UIImage*)getSubImage:(CGRect)rect;//获取部分图像
-(UIImage *)cropImage:(float)left right:(float)right top:(float)top button:(float)bottom;//裁剪
- (UIImage *)imageAtRect:(CGRect)rect;




- (UIImage *)imageByScalingToSize:(CGSize)targetSize;//等比缩放
-(UIImage *)imageExtendToSize:(CGSize)size isBasedOnHeight:(BOOL)isBasedOnHeight  isByLeft:(BOOL)isByLeft;//扩展，从左边或者从右边
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;


- (UIImage *) imageWithTintColor:(UIColor *)tintColor;


@end
