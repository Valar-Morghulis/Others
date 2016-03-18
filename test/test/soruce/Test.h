//
//  Test.h
//  testARC
//
//  Created by smallpay on 15/11/4.
//  Copyright © 2015年 smallpay. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Test : NSObject<NSCopying>
{
    NSString * name;
}
@property(copy) NSString *str1;
@property(strong) NSString *str2;

@end


@interface Test2 : NSObject
@property(nonatomic,assign)Test * t;

@end
