//
//  UIView+Image.m
//  SBTickerViewDemo
//
//  Created by MaYing on 14-10-9.
//  Copyright (c) 2014年 Doubleint. All rights reserved.
//

#import "UIView+Image.h"

@implementation UIView(Image)
-(UIImage *)image
{
    float scale = [UIScreen mainScreen].scale;
	UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, scale);
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
	return image;
}

@end
