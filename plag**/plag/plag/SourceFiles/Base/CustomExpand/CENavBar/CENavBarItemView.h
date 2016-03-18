//
//  CENavBarItemView.h
//  ShoppingMall
//
//  Created by MaYing on 13-11-15.
//
//

#import <UIKit/UIKit.h>
#import "CTDownImageView.h"
#import "CTUtility.h"

@class CENavBarItemView;
@protocol CENavBarItemViewDelegate <NSObject>
-(void)itemSelected:(CENavBarItemView *)item data:(NSDictionary *)data;
-(void)itemUnselected:(CENavBarItemView *)item data:(NSDictionary *)data;

@end

@interface CENavBarItemView : UIView<CTDownImageViewDelegate>
{
    NSDictionary * _data;
    id<CENavBarItemViewDelegate> _delegate;
}
@property(nonatomic,retain) NSDictionary *_data;

@property(nonatomic,assign) id<CENavBarItemViewDelegate> _delegate;
//
-(void)initlizeWithFrame:(CGRect)frame;
-(void)parseData;
-(void)setSelected:(BOOL)animated;
-(void)setUnselected:(BOOL)animated;
-(CGRect)autoAdjustFrame:(CGRect)originFrame data:(NSDictionary *)data;//

-(CENavBarItemView *)deepCopy;
@end
