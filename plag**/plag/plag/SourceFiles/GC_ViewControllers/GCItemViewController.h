//
//  GCItemViewController.h
//  plag
//
//  Created by MaYing on 15/6/3.
//  Copyright (c) 2015年 xiaofu. All rights reserved.
//

#import "GCBaseViewController.h"

#import "GCItemBar.h"

@interface GCItemViewController : GCBaseViewController<CENavBarDelegate,UIScrollViewDelegate>
{
    GCItemBar * _itemBar;
    //
    UIScrollView * _scrollView;
}
@property(nonatomic,retain) GCItemBar * _itemBar;
@property(nonatomic,retain) UIScrollView * _scrollView;


@end
