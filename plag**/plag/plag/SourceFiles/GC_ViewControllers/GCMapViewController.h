//
//  GCMapViewController.h
//  plag
//
//  Created by MaYing on 15/6/11.
//  Copyright (c) 2015年 xiaofu. All rights reserved.
//

#import "GCBaseViewController.h"

@interface GCMapViewController : GCBaseViewController<GCMapViewDelegate>
{
    GCMapView * _mapView;
}
@property(nonatomic,retain) GCMapView * _mapView;
@end
