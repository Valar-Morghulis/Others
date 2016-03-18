//
//  CTFlipDoubleSidedLayer.h
//  PaiHaoBao
//
//  Created by MaYing on 14-10-9.
//  Copyright (c) 2014年 MaYing. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CTFlipDoubleSidedLayer : CATransformLayer
{
    CALayer * _frontLayer;
    CALayer * _backLayer;
}
@property (nonatomic, retain) CALayer * _frontLayer;
@property (nonatomic, retain) CALayer * _backLayer;
@end
