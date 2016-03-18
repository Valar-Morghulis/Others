//
//  CTZoomImageView.h
//  CTZoomImageView
//
//  Created by MaYing on 14-4-25.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CTZoomImageView;
@protocol CTZoomImageViewDelegate
-(void)pick:(CTZoomImageView *)imageView pointInImageView:(CGPoint) pointInImageView pointInScroll:(CGPoint)pointInScroll pointInPixel:(CGPoint) pointInPixel;
@end
@interface CTZoomImageView : UIScrollView<UIScrollViewDelegate>
{
    UIImageView * _imageView;//图片

    float _minScale;//最小scale
    float _maxScale;//最大scale
    float _zoomStep;//
    id<CTZoomImageViewDelegate> _zoomDelegate;
}
@property(nonatomic,assign) id<CTZoomImageViewDelegate> _zoomDelegate;
@property(nonatomic,readwrite) float _minScale;//最小scale
@property(nonatomic,readwrite) float _maxScale;//最大scale
@property(nonatomic,readwrite) float _zoomStep;//

@property(nonatomic,readonly) float _nowScale;//当前scale


-(void)displayImage:(UIImage *)image;

//平移
-(void)moveToPointInImageView:(CGPoint)pointInImageView;//将imageView中pointInImageView处的像素放在中心点位置
-(void)moveToPointInScroll:(CGPoint)pointInScroll;//将scroll中pointInScroll处的像素放在中心点位置
-(void)moveToPointInPixel:(CGPoint)pointInPixel;//将图片上pointInPixel处的像素放在中心点位置

//缩放
-(void)zoomToNewScale:(float)newScale pointInImageView:(CGPoint) pointInImageView;//以imageView中pointInImageView为中心点放大到newScale值
-(void)zoomToNewScale:(float)newScale pointInScroll:(CGPoint) pointInScroll;//以scroll中pointInScroll为中心点放大到newScale值
-(void)zoomToNewScale:(float)newScale pointInPixel:(CGPoint) pointInPixel;//以图片上的pointInPixel像素点为中心点，放大到newScale值

//坐标变换
-(CGPoint)pointInPixelToPointInImageView:(CGPoint)pointInPixel zoom:(float)zoom;//图片像素坐标 ---> imageView坐标
-(CGPoint)pointInImageViewToPointInPixel:(CGPoint)pointInImageView zoom:(float)zoom;//imageView坐标 ---> 图片像素坐标
-(CGPoint)pointInScrollToPointInImageView:(CGPoint)pointInScroll zoom:(float)zoom;//scroll坐标 ---> imageView坐标
-(CGPoint)pointInImageViewToPointInScroll:(CGPoint)pointInImageView zoom:(float)zoom;//imageView坐标 ---> scroll坐标
@end
