//
//  TestTask.m
//  test
//
//  Created by smallpay on 16/1/26.
//  Copyright © 2016年 xmg. All rights reserved.
//

#import "TestTask.h"

@implementation TestTask
@synthesize _network;
-(void)dealloc
{
    self._network = 0;
    [super dealloc];
}
-(id)initWithName:(NSString *)name
{
    if(self = [super initWithName:name])
    {
        _network = [[CTNetwork alloc] init];
        _network._delegate = self;
    }
    return self;
}

-(void)main
{
    _network;
}
-(void)start
{
    
}
- (void)didCancel
{
    [_network cancelLoading];
}
- (void)didReset
{
    [CTNetwork pushBackup:_network];
}
- (void)didRetry
{
    [CTNetwork resumeAndRetry:_network];
}



#pragma mark CTNetworkDelegate
-(void)beforeNetworkStart:(CTNetwork *)network
{
    NSLog(@"start");
}
-(BOOL)isResultVaild:(CTNetwork *)network data:(NSDictionary *)data
{
    return TRUE;
}
-(void)networkStoped:(CTNetwork *)network success:(int)success
{
    if(success == Result_Succeed)
    {
        NSLog(@"%d--%@",network._netTag,network._url);
    }
    else
    {
        [CTNetwork pushBackup:network];
    }
}
-(void)afterNetworkStoped:(CTNetwork *)network
{
    NSLog(@"end");
}

@end
