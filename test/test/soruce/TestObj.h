//
//  TestObj.h
//  test
//
//  Created by smallpay on 15/10/27.
//  Copyright © 2015年 xmg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestObj : NSObject
{
    NSString * _name;
}
@property(nonatomic,retain)NSString * name;
@property(nonatomic,retain)NSString * address;
@property(nonatomic,retain)NSString * tel;
@property(nonatomic,retain)NSString * label;

@property(nonatomic,readonly,retain) NSString * sex;
@property(nonatomic,readonly,retain) NSString * hobies;
@property(nonatomic,readonly) NSString * desc;
@end
