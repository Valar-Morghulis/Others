//
//  CEWaterfallView.h
//  ShoppingInLZ
//
//  Created by MaYing on 14-5-16.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CECollectionView.h"
#import "CEWaterfallViewDataSource.h"

@interface CEWaterfallView : UIView<CEWaterfallViewDataSourceDelegate>
{
    CEWaterfallViewDataSource * _dataSource;
    CECollectionView * _collectionView;
}
@property(nonatomic,retain)  CECollectionView * _collectionView;
@property(nonatomic,retain) CEWaterfallViewDataSource * _dataSource;
@end
