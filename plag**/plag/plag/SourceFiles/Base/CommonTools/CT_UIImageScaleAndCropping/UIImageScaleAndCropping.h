//
//  UIImageScaleAndCropping.h
//  Shopping_Mall
//
//  Created by MaYing on 13-10-6.
//
//

#import <Foundation/Foundation.h>

@interface UIImage(UIImageScaleAndCropping)

-(UIImage*)getSubImage:(CGRect)rect;//获取部分图像
-(UIImage*)scaleToTargetSize:(CGSize)size;//缩放
-(UIImage *)cropImage:(float)left right:(float)right top:(float)top button:(float)bottom;//裁剪


//
- (UIImage *)imageAtRect:(CGRect)rect;
- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize;
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;


- (CGSize )getImageRectByScalingToSize:(CGSize)targetSize;
@end
