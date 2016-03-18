//
//  CEWaterfallViewCell.h
//  ShoppingInLZ
//
//  Created by MaYing on 14-5-16.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import "CECollectionViewCell.h"
#import "GC_ConstantDefine.h"
#import "APP_GlobeDefine.h"
#import "CTDownImageView.h"
#import "CTUtility.h"

@interface CEWaterfallViewCell : CECollectionViewCell<CTDownImageViewDelegate>
- (void)layoutSubviews;//在此方法内根据self.frame进行调整位置
@end
