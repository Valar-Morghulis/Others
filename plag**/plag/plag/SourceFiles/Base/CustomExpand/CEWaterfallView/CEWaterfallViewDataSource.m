//
//  CEWaterfallViewDataSource.m
//  ShoppingInLZ
//
//  Created by MaYing on 14-5-16.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import "CEWaterfallViewDataSource.h"

@implementation CEWaterfallViewDataSource
@synthesize _delegate;
@synthesize _datas;
-(void)dealloc
{
    self._datas = 0;
    [super dealloc];
}
-(void)set_datas:(NSArray *)datas
{
    if(_datas != datas)
    {
        if(_datas) [_datas release];
        _datas = datas;
        if(_datas) [_datas retain];
        if(self._delegate)
        {
            [self._delegate dataChanged:self];
        }
    }
}


#pragma mark CECollectionViewDataSource
- (NSInteger)numberOfViewsInCollectionView:(CECollectionView *)collectionView
{
    return [self._datas count];
}
- (CECollectionViewCell *)collectionView:(CECollectionView *)collectionView viewAtIndex:(NSInteger)index
{
    NSDictionary * dic = [self._datas objectAtIndex:index];
    int type = [[dic objectForKey:@"showType"] intValue];
    NSString * reuseIdentifier = 0;
    if(type == CEWaterfallViewCellType_Text)
    {
        reuseIdentifier = NSStringFromClass([CEWaterfallViewCell_Text class]);
    }
    else if(type == CEWaterfallViewCellType_Normal)
    {
        reuseIdentifier = NSStringFromClass([CEWaterfallViewCell_Normal class]);
    }
    else
    {
        reuseIdentifier = NSStringFromClass([CEWaterfallViewCell class]);
    }
    CECollectionViewCell * cell = [collectionView dequeueReusableView:reuseIdentifier];
    if(!cell)
    {
        cell = [[[NSClassFromString(reuseIdentifier) alloc] initWithFrame:CGRectZero reuseIdentifier:reuseIdentifier] autorelease];
    }
    [cell fillViewWithObject:dic];
    return cell;
}
- (CGFloat)heightForViewAtIndex:(CECollectionView *)collectionView index:(NSInteger)index
{
    NSDictionary * dic = [self._datas objectAtIndex:index];
    int type = [[dic objectForKey:@"showType"] intValue];
    NSString * className = 0;
    if(type == CEWaterfallViewCellType_Text)
    {
        className = NSStringFromClass([CEWaterfallViewCell_Text class]);
    }
    else if(type == CEWaterfallViewCellType_Normal)
    {
        className = NSStringFromClass([CEWaterfallViewCell_Normal class]);
    }
    else
    {
        className = NSStringFromClass([CEWaterfallViewCell class]);
    }
    return [NSClassFromString(className) heightForViewWithObject:dic inColumnWidth:collectionView.colWidth];
}

@end
