//
//  CEScrollPageSource.h
//  ShoppingInLZ
//
//  Created by MaYing on 14-5-14.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CEScrollPage.h"

@interface CEScrollPageSource : NSObject
{
    id<CEScrollPageDelegate> _pageDelegate;
}
@property(nonatomic,assign) id<CEScrollPageDelegate> _pageDelegate;
-(CEScrollPage *)pageInFrame:(CGRect) frame Data:(NSDictionary *)data;
@end
