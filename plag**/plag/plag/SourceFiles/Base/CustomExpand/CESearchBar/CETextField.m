//
//  CETextField.m
//  ShoppingInLZ
//
//  Created by MaYing on 14-7-9.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import "CETextField.h"

@implementation CETextField

#define kTextFieldPaddingWidth  0
#define kTextFieldPaddingHeight 0


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds,
                       self.dx == 0.0f ? kTextFieldPaddingWidth : self.dx,
                       self.dy == 0.0f ? kTextFieldPaddingHeight : self.dy);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds,
                       self.dx == 0.0f ? kTextFieldPaddingWidth : self.dx,
                       self.dy == 0.0f ? kTextFieldPaddingHeight : self.dy);
}

- (void)setDx:(CGFloat)dx
{
    _dx = dx;
    [self setNeedsDisplay];
}

- (void)setDy:(CGFloat)dy
{
    _dy = dy;
    [self setNeedsDisplay];
}

@end
