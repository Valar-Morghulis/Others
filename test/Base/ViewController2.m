//
//  ViewController2.m
//  Base
//
//  Created by MaYing on 15/7/17.
//  Copyright (c) 2015年 xmg. All rights reserved.
//

#import "ViewController2.h"

@implementation ViewController2
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[[UIApplication sharedApplication] setStatusBarHidden:TRUE];
[self.navigationController.navigationBar setBarTintColor:[UIColor greenColor]];
    
}


- (BOOL)prefersStatusBarHidden
{
    return TRUE;
}

@end
