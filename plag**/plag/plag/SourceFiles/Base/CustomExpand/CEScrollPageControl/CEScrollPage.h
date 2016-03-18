//
//  CEScrollPage.h
//  ShoppingInLZ
//
//  Created by MaYing on 14-5-14.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTUtility.h"
#import "CTDownImageView.h"

@class CEScrollPage;
@protocol CEScrollPageDelegate
-(void)pageSelected:(CEScrollPage *) page data:(NSDictionary *)data;
@end
@interface CEScrollPage : UIView<CTDownImageViewDelegate>
{
    UIButton * _coverButton;
    NSDictionary * _data;
    id<CEScrollPageDelegate> _delegate;
}
@property(nonatomic,retain) UIButton * _coverButton;
@property(nonatomic,retain) NSDictionary * _data;
@property(nonatomic,assign)  id<CEScrollPageDelegate> _delegate;
//
-(void)parseData;
@end
