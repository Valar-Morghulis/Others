//
//  CEWaterfallViewCell.m
//  ShoppingInLZ
//
//  Created by MaYing on 14-5-16.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import "CEWaterfallViewCell.h"
#import "CTDevice.h"
@implementation CEWaterfallViewCell
-(id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor whiteColor];
        float borderWidth = 1;
        if(IS_IOS7_OR_LATER)
            borderWidth = 0.5;
        
        self.layer.borderWidth = borderWidth;
        self.layer.borderColor = RGBA(200, 200, 200, 1).CGColor;
    }
    return self;
}
- (void)prepareForReuse
{
    
}
- (void)fillViewWithObject:(id)object
{
    [super fillViewWithObject:object];
}
+ (CGFloat)heightForViewWithObject:(id)object inColumnWidth:(CGFloat)columnWidth
{
    return 0;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}
#pragma mark CTDownImageViewDelegate
-(void)afterDownImageViewSucceed:(CTDownImageView *) imageView image:(UIImage *)image url:(NSString *)url
{
    NSString *imagename = [CTUtility MD5Encode:url];
    [CTUtility CachImageWithName:imagename img:image];
}


@end
