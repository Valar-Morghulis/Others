//
//  CEWaterfallViewCell_Normal.h
//  ShoppingInLZ
//
//  Created by MaYing on 14-5-16.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import "CEWaterfallViewCell.h"

@interface CEWaterfallViewCell_Normal : CEWaterfallViewCell
{
    CTDownImageView * _imageView;
    UILabel * _titleLabel;
    UILabel * _descLabel;
    UIImageView * _preferentialImageView;
}
@property(nonatomic,retain) CTDownImageView * _imageView;
@property(nonatomic,retain) UILabel * _titleLabel;
@property(nonatomic,retain) UILabel * _descLabel;
@property(nonatomic,retain) UIImageView * _preferentialImageView;
@end
