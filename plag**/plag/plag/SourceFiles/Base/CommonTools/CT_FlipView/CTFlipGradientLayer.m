//
//  CTFlipGradientLayer.m
//  SBTickerViewDemo
//
//  Created by MaYing on 14-10-9.
//  Copyright (c) 2014年 Doubleint. All rights reserved.
//

#import "CTFlipGradientLayer.h"


@implementation CTFlipGradientLayer
@synthesize _gradientLayer;
@synthesize _gradientMaskLayer;
@synthesize _gradientOpacity;
@synthesize _layerSegment;
@synthesize _layerType;
@synthesize _maxOpacity;
@synthesize _minOpacity;
-(void)dealloc
{
    self._gradientLayer = 0;
    self._gradientMaskLayer = 0;
    [super dealloc];
}
-(id)initWithStyle:(CTFlipGradientLayerType)type segment:(CTFlipGradientLayerSegment)segment
{
    if(self = [super init])
    {
        _layerType = type;
        _layerSegment = segment;
		
        [self setMasksToBounds:YES];
        //
        self._gradientLayer = [CAGradientLayer layer];
        self._gradientLayer.frame = self.bounds;
		[self addSublayer:self._gradientLayer];
        [self setContentsScale:[[UIScreen mainScreen] scale]];
		
        _minOpacity = 0.;
        self._gradientMaskLayer = [CALayer layer];
        [self._gradientMaskLayer setContentsScale:[[UIScreen mainScreen] scale]];
        [self._gradientLayer setMask:self._gradientMaskLayer];
        
		if (type == CTFlipGradientLayerTypeFace)
        {
			[self._gradientLayer setColors:[NSArray arrayWithObjects:
                                       (id)[UIColor colorWithWhite:0. alpha:.5].CGColor,
                                       (id)[UIColor colorWithWhite:0. alpha:1.].CGColor,
                                       nil]];
            
			[self._gradientLayer setLocations:[NSArray arrayWithObjects:
                                          [NSNumber numberWithFloat:0.],
                                          [NSNumber numberWithFloat:1.],
                                          nil]];
			
			_maxOpacity = .75;
		}
        else
        {
			[self._gradientLayer setColors:[NSArray arrayWithObjects:
                                       ( id)[UIColor colorWithWhite:0. alpha:0.].CGColor,
                                       ( id)[UIColor colorWithWhite:0. alpha:.5].CGColor,
                                       ( id)[UIColor colorWithWhite:0. alpha:1.].CGColor,
                                       nil]];
            
			[self._gradientLayer setLocations:[NSArray arrayWithObjects:
                                          [NSNumber numberWithFloat:.2],
                                          [NSNumber numberWithFloat:.4],
                                          [NSNumber numberWithFloat:1.],
                                          nil]];
			
            
			_maxOpacity = 1.;
		}
        
        if (segment == CTFlipGradientLayerSegmentTop)
        {
            [self setContentsGravity:kCAGravityBottom];
            [self._gradientLayer setStartPoint:CGPointMake(0., 0.)];
            [self._gradientLayer setEndPoint:CGPointMake(0., 1.)];
            
            [self._gradientMaskLayer setContentsGravity:kCAGravityBottom];
        }
        else
        {
            [self setContentsGravity:kCAGravityTop];
            
            [self._gradientLayer setStartPoint:CGPointMake(0., 1.)];
            [self._gradientLayer setEndPoint:CGPointMake(0., 0.)];
            
            [self._gradientMaskLayer setContentsGravity:kCAGravityTop];
        }
        
		[self._gradientLayer setOpacity:_minOpacity];
    }
    return self;
}
- (void)layoutSublayers
{
	[super layoutSublayers];
	[self._gradientLayer setFrame:self.bounds];
    [self._gradientMaskLayer setFrame:self.bounds];
}
- (float)_gradientOpacity
{
	return self._gradientLayer.opacity;
}

- (void)set_gradientOpacity:(float)opacity
{
	[self._gradientLayer setOpacity:(opacity * (_maxOpacity - _minOpacity) + _minOpacity)];
}

- (void)setContents:(id)contents
{
    [super setContents:contents];
    
    [self._gradientMaskLayer setContents:contents];
}
@end
