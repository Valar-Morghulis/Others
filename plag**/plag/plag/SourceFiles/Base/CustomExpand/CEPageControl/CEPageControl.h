//
//  CEPageControl.h
//  GuangCity
//
//  Created by MaYing on 14-10-23.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CEPageControl : UIView
{
    UIImage * _activeImage;
    UIImage * _inactiveImage;
    float _itemDis;//间距
    
    int _currentIndex;
    NSMutableArray * _dots;//
    int _numberOfPages;//
}
@property(nonatomic,retain) UIImage * _activeImage;
@property(nonatomic,retain) UIImage * _inactiveImage;
@property(nonatomic,readwrite) float _itemDis;//间距
@property(nonatomic,readwrite)  int _numberOfPages;

@property(nonatomic,assign) int _currentIndex;
-(void)updateCurrentPageIndex:(int)page;
@end
