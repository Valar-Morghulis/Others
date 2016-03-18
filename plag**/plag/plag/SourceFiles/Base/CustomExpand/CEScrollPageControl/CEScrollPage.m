//
//  CEScrollPage.m
//  ShoppingInLZ
//
//  Created by MaYing on 14-5-14.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import "CEScrollPage.h"

@implementation CEScrollPage
@synthesize _data;
@synthesize _delegate;
@synthesize _coverButton;
-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self._coverButton = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)] autorelease];
        self._coverButton.backgroundColor = [UIColor clearColor];
        [self addSubview:self._coverButton];
        [self._coverButton addTarget:self action:@selector(coverButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(void)dealloc
{
    self._coverButton = 0;
    self._data = 0;
    [super dealloc];
}
-(void)coverButtonClicked
{
    if(self._delegate)
    {
        [self._delegate pageSelected:self data:self._data];
    }
}
-(void)set_data:(NSDictionary *)data
{
    if(data != _data)
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
