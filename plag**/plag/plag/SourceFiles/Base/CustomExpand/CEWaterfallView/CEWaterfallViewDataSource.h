//
//  CEWaterfallViewDataSource.h
//  ShoppingInLZ
//
//  Created by MaYing on 14-5-16.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CECollectionView.h"
#import "CEWaterfallViewCell.h"
#import "CEWaterfallViewCell_Normal.h"
#import "CEWaterfallViewCell_Text.h"

@class CEWaterfallViewDataSource;
@protocol CEWaterfallViewDataSourceDelegate
-(void)dataChanged:(CEWaterfallViewDataSource *)dataSource;
@end

@interface CEWaterfallViewDataSource : NSObject<CECollectionViewDataSource>
{
    id<CEWaterfallViewDataSourceDelegate> _delegate;
    NSArray * _datas;
}
@property(nonatomic,assign)  id<CEWaterfallViewDataSourceDelegate> _delegate;
@property(nonatomic,retain) NSArray * _datas;
@end
