//
//  GCDragMoveHeaderAndFooter.m
//  plag
//
//  Created by MaYing on 15/6/2.
//  Copyright (c) 2015年 xiaofu. All rights reserved.
//

#import "GCDragMoveHeaderAndFooter.h"

@implementation GCDragMoveBaseView
-(void)changeState{}
-(void)recoverState{}
@end

@implementation GCDragMoveHeader
@synthesize _label;
-(void)dealloc
{
    self._label = 0;
    [super dealloc];
}
-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.autoresizesSubviews = TRUE;
        //
        self._label = [[[UILabel alloc] initWithFrame:self.bounds] autorelease];
        [self addSubview:self._label];
        self._label.textAlignment = NSTextAlignmentCenter;
        self._label.font = [UIFont systemFontOfSize:13];
        self._label.numberOfLines = 1;
        self._label.lineBreakMode = NSLineBreakByTruncatingTail;
        self._label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self recoverState];
    }
    return self;
}
-(void)changeState
{
    self.backgroundColor = RGBA(218, 218, 218, 1);
    self._label.textColor = RGBA(174, 174, 174, 1);
    self._label.text = @"RELEASE TO SKIP";
}
-(void)recoverState
{
    self.backgroundColor = RGBA(0, 131, 225, 1);
    self._label.textColor = RGBA(109, 181, 233, 1);
    self._label.text = @"SPREAD";
}
@end

@implementation GCDragMoveFooter
@synthesize _label;
-(void)dealloc
{
    self._label = 0;
    [super dealloc];
}
-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.autoresizesSubviews = TRUE;
        //
        self._label = [[[UILabel alloc] initWithFrame:self.bounds] autorelease];
        [self addSubview:self._label];
        self._label.textAlignment = NSTextAlignmentCenter;
        self._label.font = [UIFont systemFontOfSize:13];
        self._label.numberOfLines = 1;
        self._label.lineBreakMode = NSLineBreakByTruncatingTail;
        self._label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self recoverState];
    }
    return self;
}
-(void)changeState
{
    self.backgroundColor = RGBA(0, 131, 225, 1);
    self._label.textColor = RGBA(109, 181, 233, 1);
    self._label.text = @"RELEASE TO INFECT 4 PEOPLE";
}
-(void)recoverState
{
    self.backgroundColor = RGBA(218, 218, 218, 1);
    self._label.textColor = RGBA(174, 174, 174, 1);
    self._label.text = @"SKIP";
}
@end