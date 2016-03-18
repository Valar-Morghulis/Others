//
//  TestTask.h
//  test
//
//  Created by smallpay on 16/1/26.
//  Copyright © 2016年 xmg. All rights reserved.
//

#import <Task/Task.h>
#import "CTNetwork.h"
@interface TestTask : TSKTask<CTNetworkDelegate>
@property(nonatomic,retain) CTNetwork * _network;
@end
