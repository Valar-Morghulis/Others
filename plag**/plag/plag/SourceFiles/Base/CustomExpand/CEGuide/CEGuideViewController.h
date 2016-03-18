//
//  CEGuideViewController.h
//  GX_Shopping_Map
//
//  Created by MaYing on 13-9-16.
//  Copyright (c) 2013年 MaYing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YAJL.h"
#import "CustomExpandDefine.h"
#import "CEBaseViewController.h"
@class CEGuideViewController;
@protocol CEGuideViewControllerDelegate
-(void)guideFinished:(CEGuideViewController *)controller;
@end

@interface CEGuideViewController : CEBaseViewController<UIScrollViewDelegate>
{
    NSString * _guideConfigFilePath;
    id<CEGuideViewControllerDelegate> _delegate;
    BOOL _isGuideUsedBefore;
    
    NSMutableDictionary * _configDic;
    NSString * _isGuideUsedKey;//key
}
@property(nonatomic,assign)id<CEGuideViewControllerDelegate> _delegate;
@property(nonatomic,readonly) BOOL _isGuideUsedBefore;
@property(nonatomic,retain) NSString * _isGuideUsedKey;//key
@property(nonatomic,retain) NSMutableDictionary * _configDic;

-(void)initlizeWithKey:(NSString *)key;//初始化
-(void)makeGuideView;
-(void)finishGuide;
-(void)saveToFile;//
@end
