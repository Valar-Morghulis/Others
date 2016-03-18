//
//  GCMapViewController.m
//  plag
//
//  Created by MaYing on 15/6/11.
//  Copyright (c) 2015年 xiaofu. All rights reserved.
//

#import "GCMapViewController.h"

@implementation GCMapViewController
@synthesize _mapView;

-(void)dealloc
{
    self._mapView = 0;
    [super dealloc];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self._mapView.delegate = 0;
}
-(BOOL)canDragBack
{
    return FALSE;//
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    //
    
    self.view.backgroundColor = [UIColor whiteColor];
  
    //
    float backOriginX = 16;
    float backOriginY = 16;
    float backWidth = 32;
    float backHeight = backWidth;
    UIButton * backButton = [[[UIButton alloc] initWithFrame:CGRectMake(backOriginX, backOriginY, backWidth, backHeight)] autorelease];
    [self.view addSubview:backButton];
    [backButton addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"back_action.png"] forState:UIControlStateSelected];
    [backButton setImage:[UIImage imageNamed:@"back_action.png"] forState:UIControlStateHighlighted];
    //
    //
    GCMapView * mapView = [[GCMapView alloc] initWithFrame:self.view.bounds];
    self._mapView = mapView;
    [mapView release];
    [self.view insertSubview:self._mapView atIndex:0];
    self._mapView.delegate = self;
    [self._mapView setUserInteractionEnabled:YES];
    CLLocationCoordinate2D mapCenter = {39.918968,116.368571};
    GCCoordinateSpan mapSpan = {0.1,0.1};
    [self setMapRegionWithSpan:mapSpan center:mapCenter];
}
-(void)backClicked
{
    [self back:0];
}
-(void)setMapRegionWithSpan:(GCCoordinateSpan)span center:(CLLocationCoordinate2D)center
{
    GCCoordinateRegion region;
    region.center = center;
    region.span = span;
    
    [self._mapView setRegion:region animated:YES];
}
#pragma mark GCMapViewDelegate
@end
