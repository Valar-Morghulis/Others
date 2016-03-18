//
//  ViewController.m
//  Base
//
//  Created by MaYing on 15/7/17.
//  Copyright (c) 2015年 xmg. All rights reserved.
//

#import "ViewController.h"
#import "ViewController2.h"
#import "CTUtility.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    //[[UIApplication sharedApplication] setStatusBarHidden:TRUE];

    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    button = [[UIButton alloc] initWithFrame:CGRectMake(250, 100, 100, 100)];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor greenColor];
    [button addTarget:self action:@selector(buttonClicked2) forControlEvents:UIControlEventTouchUpInside];
}
-(void)buttonClicked
{
    //CTAlertView * alert = [[CTAlertView alloc] initWithTitle:@"提示" message:@"1" delegate:0 cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    //[alert show];
 
    [self.navigationController pushViewController:[[ViewController2 alloc] init] animated:TRUE];
    
    

}
-(void)buttonClicked2
{

    //修改导航条按钮
    float buttonHeight = 44;
    float buttonWidth = 44;
    #if 1
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, buttonHeight)];
    [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [leftButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    //[leftButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    leftButton.backgroundColor = [UIColor yellowColor];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
   
    //
    
    UIButton *leftButton2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, buttonHeight)];
    [leftButton2 setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [leftButton2 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [leftButton2 setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    //[leftButton2 addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    leftButton2.backgroundColor = [UIColor purpleColor];
    UIBarButtonItem *leftButtonItem2 = [[UIBarButtonItem alloc] initWithCustomView:leftButton2];
    
    
    [self.navigationItem setLeftBarButtonItem:leftButtonItem];
    //[self.navigationItem setLeftBarButtonItems:@[leftButtonItem,leftButtonItem2]];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, buttonHeight)];
    [rightButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [rightButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    //[rightButton addTarget:self action:@selector(home:) forControlEvents:UIControlEventTouchUpInside];
     rightButton.backgroundColor = [UIColor yellowColor];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    
    
    //
    UIButton *rightButton2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, buttonHeight)];
    [rightButton2 setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [rightButton2 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [rightButton2 setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    //[rightButton addTarget:self action:@selector(home:) forControlEvents:UIControlEventTouchUpInside];
    rightButton2.backgroundColor = [UIColor purpleColor];
    UIBarButtonItem *rightButtonItem2 = [[UIBarButtonItem alloc] initWithCustomView:rightButton2];
    
    
    //[self.navigationItem setRightBarButtonItem:rightButtonItem];
 [self.navigationItem setRightBarButtonItems:@[rightButtonItem,rightButtonItem2]];
    
    [self.navigationItem setTitle:@"1231231"];
    self.navigationItem.prompt = @"aaaaa";

    self.navigationItem.leftItemsSupplementBackButton = true;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:true];
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    
    
    {
        UIButton * v = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
        [v addTarget:self action:@selector(vClicked) forControlEvents:UIControlEventTouchUpInside];
        v.backgroundColor = [UIColor whiteColor];
        //self.navigationItem.titleView  = v;
        
        
    }
#endif
    {
        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, buttonHeight)];
        [rightButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [rightButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [rightButton setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
        //[rightButton addTarget:self action:@selector(home:) forControlEvents:UIControlEventTouchUpInside];
        rightButton.backgroundColor = [UIColor yellowColor];
        UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        
        
        
        //
        UIButton *rightButton2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, buttonHeight)];
        [rightButton2 setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [rightButton2 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [rightButton2 setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
        //[rightButton addTarget:self action:@selector(home:) forControlEvents:UIControlEventTouchUpInside];
        rightButton2.backgroundColor = [UIColor purpleColor];
        UIBarButtonItem *rightButtonItem2 = [[UIBarButtonItem alloc] initWithCustomView:rightButton2];
        
        [self.navigationController  setToolbarHidden:NO animated:YES];
      
        self.toolbarItems = @[rightButtonItem,rightButtonItem2];
        
        
    
    }
    {
        NSArray *array = [NSArray arrayWithObjects:@"鸡翅",@"排骨", nil];
        UISegmentedControl *segmentedController = [[UISegmentedControl alloc] initWithItems:array];
        segmentedController.segmentedControlStyle = UISegmentedControlSegmentCenter;
        
        [segmentedController addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
        self.navigationItem.titleView = segmentedController;
    }
    
    //self.navigationController.hidesBarsOnSwipe = TRUE;
    
}
-(void)segmentAction:(id)sender
{
    NSLog(@"%@",sender);
}
-(void)vClicked
{
    
}
- (void)viewDidAppear:(BOOL)animated

{
    
    [super viewDidAppear:animated];
    
    [UIApplication sharedApplication].statusBarHidden = TRUE;

    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
    {
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    else
    {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:YES];
    }
    
}
- (BOOL)prefersStatusBarHidden
{
    return false;
}


@end
