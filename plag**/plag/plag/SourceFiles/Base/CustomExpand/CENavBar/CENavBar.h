//
//  CENavBar.h
//  GX_GuangShopping
//
//  Created by yaoyongping on 13-9-25.
//
//

#import <UIKit/UIKit.h>
#import "CENavBarItemView.h"
#import "APP_GlobeDefine.h"
#import "CustomExpandDefine.h"
#import "CTDevice.h"
@class CENavBar;
@protocol CENavBarDelegate <CENavBarItemViewDelegate>

@end

@interface CENavBar : UIView<CENavBarItemViewDelegate,UIScrollViewDelegate>
{
    NSString * _key;//检索key
    
    UIScrollView *_scrollView;
    NSArray *_items;
    CENavBarItemView * _currentItem;
    id<CENavBarDelegate> _delegate;
    
    CENavBarItemView * _prototypeNavBarItemView;
    float _itemWidth;//单个宽度，如果不自动调整大小，将使用此宽度
    float _leftDis;//左边距
    float _itemDis;//item间距
    BOOL _autoAdjustItemFrame;//是否自动调整Item大小
}
@property(nonatomic,retain) NSString * _key;//检索key
@property(nonatomic,readonly) int  _typeIndex;
@property(nonatomic,readwrite) float _itemWidth;
@property(nonatomic,retain) UIScrollView * _scrollView;
@property(nonatomic,retain) NSArray * _items;
@property(nonatomic,retain) CENavBarItemView * _currentItem;
@property(nonatomic,assign)id<CENavBarDelegate>_delegate;
@property(nonatomic,readwrite) float _leftDis;//左边距
@property(nonatomic,readwrite) float _itemDis;//item间距
@property(nonatomic,readwrite) BOOL _autoAdjustItemFrame;//是否自动调整Item大小
@property(nonatomic,retain) CENavBarItemView * _prototypeNavBarItemView;

-(void)selectItemByTypeIndex:(int)typeIndex animate:(BOOL)animate;
-(CENavBarItemView *)itemWithTypeIndex:(int)typeIndex;

@end
