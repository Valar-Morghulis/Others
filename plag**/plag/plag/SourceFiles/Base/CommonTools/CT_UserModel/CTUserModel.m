//
//  CTUserModel.m
//  GIIBank1.0
//
//  Created by li xiangji on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CTUserModel.h"

static CTUserModel* _inscante = 0;

@implementation CTUserModel

@synthesize _sessionID, _userName;

-(id)init
{
    if (self = [super init])
    {
  
        NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
        self._userName = [userDefaults objectForKey:@"userName"];
        self._sessionID = [userDefaults objectForKey:@"sessionID"];
    }
    return self;
}

-(void)dealloc
{
    self._sessionID = 0;
    self._userName = 0;
    [super dealloc];
}



+(CTUserModel *)instance
{
    if(!_inscante)
    {
        _inscante = [[CTUserModel alloc] init];
    }
    return _inscante;
}
@end
