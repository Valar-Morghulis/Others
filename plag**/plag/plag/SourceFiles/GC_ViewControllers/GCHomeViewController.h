//
//  GCHomeViewController.h
//  BIPT_OA
//
//  Created by Thinkfer on 14-2-15.
//  Copyright (c) 2014年 Thinkfer. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "GCBaseViewController.h"

#import "GCDragDistributeView.h"

@interface GCHomeViewController : GCBaseViewController<GCDragDistributeViewDelegate>
{
    GCDragDistributeView * _distributeView;
}
@property(nonatomic,retain) GCDragDistributeView * _distributeView;

-(void)refresh;
@end
