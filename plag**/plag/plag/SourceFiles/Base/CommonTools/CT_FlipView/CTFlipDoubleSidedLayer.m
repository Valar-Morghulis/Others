//
//  CTFlipDoubleSidedLayer.m
//  PaiHaoBao
//
//  Created by MaYing on 14-10-9.
//  Copyright (c) 2014年 MaYing. All rights reserved.
//

#import "CTFlipDoubleSidedLayer.h"

@implementation CTFlipDoubleSidedLayer
@synthesize _backLayer;
@synthesize _frontLayer;
-(void)dealloc
{
    [super dealloc];
}
-(id)init
{
    if(self = [super init])
    {
        self.doubleSided = TRUE;
    }
    return self;
}
- (void)layoutSublayers
{
	[super layoutSublayers];
	
	[self._frontLayer setFrame:self.bounds];
	[self._backLayer setFrame:self.bounds];
}

-(void)set_frontLayer:(CALayer *)frontLayer
{
    if(_frontLayer != frontLayer)
    {
        if(_frontLayer)
        {
            [_frontLayer removeFromSuperlayer];
            [_frontLayer release];
        }
        _frontLayer = frontLayer;
        if(_frontLayer)
        {
            [_frontLayer retain];
            _frontLayer.doubleSided = FALSE;
            [self addSublayer:_frontLayer];
            [self setNeedsLayout];
        }
    }
}
-(void)set_backLayer:(CALayer *)backLayer
{
    if(_backLayer != backLayer)
    {
        if(_backLayer)
        {
            [_backLayer removeFromSuperlayer];
            [_backLayer release];
        }
        _backLayer = backLayer;
        if(_backLayer)
        {
            [_backLayer retain];
            [_backLayer setDoubleSided:NO];
            CATransform3D transform = CATransform3DMakeRotation(M_PI, 1., 0., 0.);
            [_backLayer setTransform:transform];
            [self addSublayer:_backLayer];
            [self setNeedsLayout];
        }
    }
}


@end
