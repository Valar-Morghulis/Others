//
//  CEVerticalBar.h
//  ShoppingInLZ
//
//  Created by Thinkfer on 14-5-17.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import <UIKit/UIKit.h>



#import "CENavBarItemView.h"
#import "APP_GlobeDefine.h"
#import "CustomExpandDefine.h"
#import "CTDevice.h"
@class CEVerticalBar;
@protocol CEVerticalBarDelegate <CENavBarItemViewDelegate>

@end

@interface CEVerticalBar : UIView<CENavBarItemViewDelegate,UIScrollViewDelegate>
{
    NSString * _key;//key
    UIScrollView *_scrollView;
    NSArray *_items;
    CENavBarItemView * _currentItem;
    id<CEVerticalBarDelegate> _delegate;
    
    CENavBarItemView * _prototypeNavBarItemView;
    float _itemHeight;//单个高度，如果不自动调整大小，将使用此高度
    float _topDis;//上边距
    float _itemDis;//item间距
    BOOL _autoAdjustItemFrame;//是否自动调整Item大小
}
@property(nonatomic,retain) NSString * _key;
@property(nonatomic,readonly) int  _typeIndex;
@property(nonatomic,readwrite) float _itemHeight;
@property(nonatomic,retain) UIScrollView * _scrollView;
@property(nonatomic,retain) NSArray * _items;
@property(nonatomic,retain) CENavBarItemView * _currentItem;
@property(nonatomic,assign)id<CEVerticalBarDelegate>_delegate;
@property(nonatomic,readwrite) float _topDis;//左边距
@property(nonatomic,readwrite) float _itemDis;//item间距
@property(nonatomic,readwrite) BOOL _autoAdjustItemFrame;//是否自动调整Item大小
@property(nonatomic,retain) CENavBarItemView * _prototypeNavBarItemView;

-(void)selectItemByTypeIndex:(int)typeIndex animate:(BOOL)animate;//根据key的值 选中

-(void)selectItemByIndex:(int)index animate:(BOOL)animate;//按照顺序进行选中



 @end