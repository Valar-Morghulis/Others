//
//  Test.m
//  testARC
//
//  Created by smallpay on 15/11/4.
//  Copyright © 2015年 smallpay. All rights reserved.
//

#import "Test.h"


@implementation Test

@synthesize str2 = _str2;
@synthesize str1;

- (id)copyWithZone:(nullable NSZone *)zone
{
    Test * t= [Test allocWithZone:zone];
    t.str1 = self.str1;
    t.str2 = self.str2;
    return t;
}
-(void)dealloc
{
   
    self.str1 = 0;
    self.str2 = 0;
    [super dealloc];
}

@end

@implementation Test2
@synthesize t =_t;
-(void)dealloc
{
    self.t = 0;
    [super dealloc];
}
-(void)setT:(Test *)t
{
    if(_t != t)
    {
        if(_t)
        {
            [_t removeObserver:self forKeyPath:@"name"];
            [_t removeObserver:self forKeyPath:@"str1"];
            [_t removeObserver:self forKeyPath:@"str2"];
        }
        _t = t;
        if(_t)
        {
            [_t addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:0];
            [_t addObserver:self forKeyPath:@"str1" options:NSKeyValueObservingOptionNew context:0];
            [_t addObserver:self forKeyPath:@"str2" options:NSKeyValueObservingOptionNew context:0];
        }
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSLog(@"%@",change);
}

@end
