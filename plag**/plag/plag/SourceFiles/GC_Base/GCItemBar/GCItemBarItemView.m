//
//  GCItemBarItemView.m
//  plag
//
//  Created by MaYing on 15/6/3.
//  Copyright (c) 2015年 xiaofu. All rights reserved.
//

#import "GCItemBarItemView.h"

@implementation GCItemBarItemView
@synthesize _label;
-(void)dealloc
{
    self._label = 0;
    [super dealloc];
}
-(void)initlizeWithFrame:(CGRect)frame
{
    [super initlizeWithFrame:frame];
    float labelWidth = 44;
    float labelHeight = labelWidth;
    float labelOriginX = (frame.size.width - labelWidth) / 2;
    float labelOriginY = (frame.size.height - labelHeight) / 2;
    //
    self._label = [[[UILabel alloc] initWithFrame:CGRectMake(labelOriginX, labelOriginY, labelWidth, labelHeight)] autorelease];
    [self addSubview:self._label];
    self._label.backgroundColor = RGBA(0, 0, 0, 0.5);
    self._label.clipsToBounds = TRUE;
    self._label.layer.cornerRadius = labelWidth / 2;
    self._label.textAlignment = NSTextAlignmentCenter;
    self._label.font = [UIFont systemFontOfSize:15];
    self._label.layer.borderColor = RGBA(59, 206, 196, 1).CGColor;
    self._label.textColor = [UIColor whiteColor];
    //
    UIButton * coverButton = [[[UIButton alloc] initWithFrame:self.bounds] autorelease];
    [self addSubview:coverButton];
    [coverButton addTarget:self action:@selector(coverButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)setSelected:(BOOL)animated
{
    CGRect frame = self.frame;
    float labelWidth = frame.size.width;
    float labelHeight = labelWidth;
    float labelOriginX = (frame.size.width - labelWidth) / 2;
    float labelOriginY = (frame.size.height - labelHeight) / 2;
    self._label.frame = CGRectMake(labelOriginX, labelOriginY, labelWidth, labelHeight);
    self._label.layer.cornerRadius = labelWidth / 2;
    self._label.layer.borderWidth = 5;
    [super setSelected:animated];
}
-(void)setUnselected:(BOOL)animated
{
    CGRect frame = self.frame;
    float labelWidth = 44;
    float labelHeight = labelWidth;
    float labelOriginX = (frame.size.width - labelWidth) / 2;
    float labelOriginY = (frame.size.height - labelHeight) / 2;
    
    self._label.frame = CGRectMake(labelOriginX, labelOriginY, labelWidth, labelHeight);
    self._label.layer.cornerRadius = labelWidth / 2;
    self._label.layer.borderWidth = 0;
    
    [super setSelected:animated];
}
-(void)coverButtonClicked
{
    [self setSelected:TRUE];
}
-(void)parseData
{
    if(self._data)
    {
        self._label.text = [self._data objectForKey:@"title"];
    }
}
@end
