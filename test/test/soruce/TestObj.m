//
//  TestObj.m
//  test
//
//  Created by smallpay on 15/10/27.
//  Copyright © 2015年 xmg. All rights reserved.
//

#import "TestObj.h"

@implementation TestObj
@synthesize name = _name;
@synthesize address = _address;
@synthesize tel;
@synthesize desc = _desc;
-(void)dealloc
{
    [_name release];
    [_address release];
    [tel release];
    
    [_label release];
    [_sex release];
    //[_hobies release];
    [super dealloc];
}
-(NSString *)hobies
{
    return 0;
}
-(NSString *)desc
{
    if(!_desc)
    {
        _desc = @"";
    }
    return _desc;
}
@end
