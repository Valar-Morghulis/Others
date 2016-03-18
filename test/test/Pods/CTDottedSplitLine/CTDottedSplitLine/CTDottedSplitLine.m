//
//  CTDottedSplitLine.m
//  Smallpay_YMD
//
//  Created by Thinkfer on 14/12/16.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import "CTDottedSplitLine.h"

@implementation CTDottedSplitLine
@synthesize _lineColor;
-(void)dealloc
{
    self._lineColor = 0;
    [super dealloc];
}
-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self._lineColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
-(void)drawRect:(CGRect)rect
{
    float lengths[] = {1.5};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, self._lineColor.CGColor);
    CGContextSetLineWidth(line, rect.size.height);
    CGContextSetLineDash(line, 0, lengths, 1);  //画虚线
    CGContextMoveToPoint(line, 0.0, 0.0);    //开始画线
    CGContextAddLineToPoint(line, rect.size.width, 0);
    CGContextStrokePath(line);
}

@end
