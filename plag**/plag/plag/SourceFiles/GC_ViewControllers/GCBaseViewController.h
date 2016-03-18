//
//  GCBaseViewController.h
//  BIPT_Base
//
//  Created by Thinkfer on 14-1-16.
//  Copyright (c) 2014年 Thinkfer. All rights reserved.
//

#import "CEBaseViewController.h"
#import "UINavigationController+CTNavigationBarBackgroundView.h"
#import "YAJL.h"
#import "GCNetwork.h"

#import "GC_ConstantDefine.h"
#import "GCNavBar.h"
#import "GCDataManager.h"

#import "UIViewController+DragBack.h"


@interface GCBaseViewController : CEBaseViewController<GCNavBarDelegate>
{
    UIView * _statusBar;
    GCNavBar * _navBar;
}
@property(nonatomic,retain) UIView * _statusBar;
@property(nonatomic,retain) GCNavBar * _navBar;

-(void)parseData;
@end
