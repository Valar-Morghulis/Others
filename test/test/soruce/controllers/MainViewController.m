//
//  MainViewController.m
//  test
//
//  Created by smallpay on 15/10/26.
//  Copyright © 2015年 xmg. All rights reserved.
//

#import "MainViewController.h"
#import "CTNetwork.h"
@interface MainViewController ()
{
  
}
@end

@implementation MainViewController
-(void)dealloc
{
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect frame = self.view.frame;
    //
    UIButton * button = [[[UIButton alloc] initWithFrame:CGRectMake(0, 310, 100, 100)] autorelease];
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor greenColor];
    [self.view addSubview:button];
    
    [self addWaitingView:TRUE];
  
    
}

-(void)buttonClicked
{
    
}

@end
