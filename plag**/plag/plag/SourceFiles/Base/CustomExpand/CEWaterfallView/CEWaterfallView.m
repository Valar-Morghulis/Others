//
//  CEWaterfallView.m
//  ShoppingInLZ
//
//  Created by MaYing on 14-5-16.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import "CEWaterfallView.h"

@implementation CEWaterfallView
@synthesize _dataSource;
@synthesize _collectionView;
-(id) initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self._dataSource = [[[CEWaterfallViewDataSource alloc] init] autorelease];
        self._dataSource._delegate = self;
        self._collectionView = [[[CECollectionView alloc] initWithFrame:CGRectMake(0, 0,frame.size.width, frame.size.height)] autorelease];
        [self addSubview:self._collectionView];
        self._collectionView.collectionViewDataSource = self._dataSource;
        
        self._collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        self._collectionView.numColsPortrait = 2;//2列
        self._collectionView.numColsLandscape = 3;//3行
        self._collectionView.backgroundColor = [UIColor clearColor];
        
        self.backgroundColor = RGBA(246, 246, 246, 1);
    }
    return self;
}
-(void)dealloc
{
    self._dataSource = 0;
    self._collectionView = 0;
    [super dealloc];
}

#pragma mark CEWaterfallViewDataSourceDelegate
-(void)dataChanged:(CEWaterfallViewDataSource *)dataSource
{
    [self._collectionView reloadData];//重新加载
}
@end
