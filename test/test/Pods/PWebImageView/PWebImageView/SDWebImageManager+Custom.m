//
//  SDWebImageManager+Custom.m
//  SPCard
//
//  Created by smallpay on 15/12/14.
//  Copyright © 2015年 star. All rights reserved.
//

#import "SDWebImageManager+Custom.h"

@implementation SDWebImageManager(Custom)
-(UIImage *)cachedImageWidthURL:(NSURL *)url
{
    UIImage * res = 0;
    NSString *key = [self cacheKeyForURL:url];
    res = [self.imageCache imageFromMemoryCacheForKey:key];
    if (!res)
        res = [self.imageCache imageFromDiskCacheForKey:key];
    return res;
}

@end
