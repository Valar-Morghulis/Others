//
//  CEMutableCellBarItemView.h
//  ShoppingInLZ
//
//  Created by MaYing on 14-5-21.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "APP_GlobeDefine.h"
#import "GC_ConstantDefine.h"

@class CEMutableCellBarItemView;
@protocol CEMutableCellBarItemViewDelegate
-(void)itemSelected:(CEMutableCellBarItemView *)item data:(NSDictionary *)data;
-(void)itemUnselected:(CEMutableCellBarItemView *)item data:(NSDictionary *)data;
@end
@interface CEMutableCellBarItemView : UIView
{
    id<CEMutableCellBarItemViewDelegate> _delegate;
    NSDictionary * _data;
}
@property(nonatomic,assign) id<CEMutableCellBarItemViewDelegate> _delegate;
@property(nonatomic,retain) NSDictionary * _data;

-(void)setSelected:(BOOL)animated;
-(void)setUnselected:(BOOL)animated;//

-(void)parseData;
@end
