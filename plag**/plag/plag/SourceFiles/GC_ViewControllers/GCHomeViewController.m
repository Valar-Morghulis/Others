//
//  GCHomeViewController.m
//  BIPT_OA
//
//  Created by Thinkfer on 14-2-15.
//  Copyright (c) 2014年 Thinkfer. All rights reserved.
//

#import "GCHomeViewController.h"
#import "HexColorString+UIColor.h"
#import "YAJL.h"

#import "GCItemViewController.h"

@implementation GCHomeViewController
@synthesize _distributeView;
-(void)dealloc
{
    self._distributeView = 0;
    [super dealloc];
}
-(BOOL)canDragBack
{
    return FALSE;//
}
-(void)viewDidLoad
{
    [super viewDidLoad];

    CGRect frame = self.view.frame;
    float dragViewOriginX = 0;
    float dragViewWidth = frame.size.width;
    float dragViewOriginY = 0;
    float dragViewHeight = frame.size.height - dragViewOriginY;
    
    self._distributeView = [[[GCDragDistributeView alloc] initWithFrame:CGRectMake(dragViewOriginX, dragViewOriginY, dragViewWidth, dragViewHeight)] autorelease];
    [self.view addSubview:self._distributeView];
    self._distributeView._delegate = self;
    
    [self._distributeView load];//
    
}
-(void)refresh
{
    
}
#pragma mark GCDragDistributeViewDelegate
-(void)beforeDistribute:(GCDragDistributeView *)view isUp:(BOOL)isUp
{
}
-(void)afterDistribute:(GCDragDistributeView *)view isUp:(BOOL)isUp
{
}

-(UIView *)anotherView
{
    CGRect bounds = self._distributeView._currentContainer.bounds;
    
#if 0
    static float r = 50;
    static float g = 50;
    static float b = 50;
    UIView * view = [[UIView alloc] initWithFrame:bounds];
    view.backgroundColor = RGBA(r, g, b, 1);
    r += 10;
    g += 10;
    b += 5;
    if(r >= 255 || g >= 255 || b >= 255)
    {
        r = g = b = 50;
    }

    return [view autorelease];
#else
    
    static BOOL b = TRUE;
    UIView * container = [[UIView alloc] initWithFrame:bounds];
    
    UIImageView * imgView = [[[UIImageView alloc] initWithFrame:bounds] autorelease];
    [container addSubview:imgView];
   if(b)
   {
        imgView.image = [UIImage imageNamed:@"test1.png"];
   }
    else
    {
        imgView.image = [UIImage imageNamed:@"test2.png"];
    }
    
    UIButton * button = [[[UIButton alloc] initWithFrame:bounds] autorelease];
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [container addSubview:button];
    
    b = !b;
    return  [container autorelease];
#endif
}
-(void)buttonClicked
{
    [self pushViewController:[[[GCItemViewController alloc] init] autorelease] animate:TRUE];
}
@end
