//
//  GCMainViewController.h
//  BIPT_Base
//
//  Created by Thinkfer on 14-1-16.
//  Copyright (c) 2014年 Thinkfer. All rights reserved.
//

#import "GCBaseViewController.h"
#import "CommonToolsDefine.h"
#import "GCHomeViewController.h"
#import "CEDynamicDataManager.h"
#import "GCLoginViewController.h"

#import "GCGuideViewController.h"

@interface GCMainViewController : GCBaseViewController<UIAlertViewDelegate,GCGuideViewControllerDelegate,GCLoginViewControllerDelegate>
{
    GCHomeViewController * _homeViewController;
}
@end
