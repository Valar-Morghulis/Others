//
//  CTTableViewCell.m
//  XFDesigners
//
//  Created by yaoyongping on 12-12-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CTTableViewCell.h"
#import "CTUtility.h"
@implementation CTTableViewCell
@synthesize _data;

-(void)dealloc
{
    self._data = 0;
    [super dealloc];
}

-(void)set_data:(NSDictionary *)data
{
    if(_data != data)
    {
        if(_data) [_data release];
        _data = data;
        if(_data) [_data retain];
        
        [self parseData];
    }
}

-(void)parseData
{
    //
}

#pragma mark CTDownImageViewDelegate
-(void)afterDownImageViewSucceed:(CTDownImageView *) imageView image:(UIImage *)image url:(NSString *)url
{
    NSString *imagename = [CTUtility MD5Encode:url];
    [CTUtility CachImageWithName:imagename img:image];
}

@end

