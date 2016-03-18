//
//  CEZoomImageView.h
//  BIPT_OA
//
//  Created by Thinkfer on 14-3-11.
//  Copyright (c) 2014年 Thinkfer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTDownImageView.h"

#define CEZoomImageView_DEFAULT_IMAGE_NAME @"defaultImage.png"

@protocol CEZoomImageViewDelegate;

@interface CEZoomImageView : UIScrollView<UIScrollViewDelegate>
{
    CGPoint  _pointToCenterAfterResize;
    CGFloat  _scaleToRestoreAfterResize;
    float _zoomStep;//放大倍数
    float _zoomCount;//放大次数
}
@property(nonatomic,readwrite) float _zoomStep;//放大倍数
@property(nonatomic,readwrite) float _zoomCount;//放大次数
@property (retain, nonatomic) CTDownImageView *_imageView;
@property (assign, nonatomic) id<CEZoomImageViewDelegate> _imageViewDelegate;

//
- (void)prepareToResize;
- (void)recoverFromResizing;
@end

@protocol CEZoomImageViewDelegate <NSObject>
- (void)imageViewDidSingleTap:(CEZoomImageView *)imageView;
- (void)imageViewDidDoubleTap:(CEZoomImageView *)imageView;


@end