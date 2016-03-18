//
//  ARData.m
//  AR_DataTransfromer
//
//  Created by MaYing on 14-2-26.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import "ARData.h"

@implementation ARData
@synthesize _alt;
@synthesize _id;
@synthesize _lat;
@synthesize _lon;
@synthesize _trademarkUrl;
@synthesize _name;
@synthesize _type;

-(void)dealloc
{
    self._trademarkUrl = 0;
    self._name = 0;
    [super dealloc];
}
@end
