//
//  CTPageControl.h
//  GIIBank1.0
//
//  Created by BIPT mac1 on 12-2-22.
//  Copyright 2012 BIPT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "APP_GlobeDefine.h"


@interface CTPageControl : UIPageControl {
	UIImage* activeImage;
    UIImage* inactiveImage;
}
@property (nonatomic, retain) UIImage *activeImage;
@property (nonatomic, retain) UIImage *inactiveImage;

-(void)updateCurrentPageIndex:(int)page;

@end

@interface CTPageControl(INFO_private) // 声明一个私有方法, 该方法不允许对象直接使用
-(void)updateDots;
@end 
