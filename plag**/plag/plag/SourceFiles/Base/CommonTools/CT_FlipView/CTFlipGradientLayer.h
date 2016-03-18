//
//  CTFlipGradientLayer.h
//  SBTickerViewDemo
//
//  Created by MaYing on 14-10-9.
//  Copyright (c) 2014年 Doubleint. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

typedef enum
{
	CTFlipGradientLayerTypeFace,
	CTFlipGradientLayerTypeTick
} CTFlipGradientLayerType;

typedef enum
{
	CTFlipGradientLayerSegmentTop,
	CTFlipGradientLayerSegmentBottom
} CTFlipGradientLayerSegment;

@interface CTFlipGradientLayer : CALayer
{
    CTFlipGradientLayerType _layerType;
    CTFlipGradientLayerSegment _layerSegment;
    float _minOpacity;
    float _maxOpacity;
    CAGradientLayer *_gradientLayer;
    CALayer *_gradientMaskLayer;
}
@property(nonatomic,readonly) CTFlipGradientLayerType _layerType;
@property(nonatomic,readonly) CTFlipGradientLayerSegment _layerSegment;

@property (nonatomic, retain) CAGradientLayer *_gradientLayer;
@property (nonatomic, retain) CALayer *_gradientMaskLayer;

@property (nonatomic, readwrite) float _minOpacity;
@property (nonatomic, readwrite) float _maxOpacity;

@property (nonatomic,readwrite) float _gradientOpacity;

- (id)initWithStyle:(CTFlipGradientLayerType)type segment:(CTFlipGradientLayerSegment)segment;
@end
