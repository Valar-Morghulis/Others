//
//  CEMutableCellBar.h
//  ShoppingInLZ
//
//  Created by MaYing on 14-5-21.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CEMutableCellBarItemView.h"

@protocol CEMutableCellBarDelegate<CEMutableCellBarItemViewDelegate>
@end

@interface CEMutableCellBar : UIView<CEMutableCellBarItemViewDelegate>
{
    float _itemWidth;//宽度
    float _colNumPerScreen;//单屏列数,每行cell的个数
    
    float _itemHeight;//高度
    float _rowNumPerScreen;//单屏行数,每列cell的个数
    
    CEMutableCellBarItemView * _currentItem;
    
    NSDictionary * _data;
    UIScrollView * _scrollView;
    NSString * _key;
    id<CEMutableCellBarDelegate> _delegate;
    
    CEMutableCellBarItemView * _prototypeItem;
}
@property(nonatomic,retain) NSString * _key;
@property(nonatomic,assign) id<CEMutableCellBarDelegate> _delegate;
@property(nonatomic,retain) CEMutableCellBarItemView * _currentItem;

@property(nonatomic,readwrite) float _itemWidth;//宽度
@property(nonatomic,readwrite) float _colNumPerScreen;//单屏列数

@property(nonatomic,readwrite) float _itemHeight;//高度
@property(nonatomic,readwrite) float _rowNumPerScreen;//单屏行数

@property(nonatomic,retain) NSDictionary * _data;
@property(nonatomic,retain) UIScrollView * _scrollView;

@property(nonatomic,retain) CEMutableCellBarItemView * _prototypeItem;

-(void)selectItemByTypeIndex:(int)index animate:(BOOL)animate;

-(void)clear;
-(void)parseData;
@end
