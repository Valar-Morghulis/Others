//
//  BaseViewController.m
//  test
//
//  Created by smallpay on 16/1/26.
//  Copyright © 2016年 xmg. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addWaitingView:(BOOL)canCancel
{
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:canCancel],@"canCancel",nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:CTAddWaitingViewKey object:dic];
}
-(void)removeWaitingView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:CTRemoveWaitingViewKey object:0];
}
//

@end
