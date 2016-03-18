//
//  CTZoomImageView.m
//  CTZoomImageView
//
//  Created by MaYing on 14-4-25.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import "CTZoomImageView.h"

@implementation CTZoomImageView
@synthesize _maxScale;
@synthesize _minScale;
@synthesize _nowScale;
@synthesize _zoomDelegate;
@synthesize _zoomStep;

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        _zoomStep = 2;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.bouncesZoom = TRUE;
        self.decelerationRate = UIScrollViewDecelerationRateFast;

        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _imageView.userInteractionEnabled = YES;
        [self addSubview:_imageView];
        [_imageView release];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
       
        UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(handleDoubleTap:)];
        [doubleTapGesture setNumberOfTapsRequired:2];
        [_imageView addGestureRecognizer:doubleTapGesture];
        [doubleTapGesture release];
        
        //
        UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(handleSingleTap:)];
        [singleTapGesture setNumberOfTapsRequired:1];
        [_imageView addGestureRecognizer:singleTapGesture];
        [singleTapGesture release];
    }
    return self;
}

-(void)displayImage:(UIImage *)image
{
    _imageView.image = image;
    [self recover];
}
-(void)set_maxScale:(float)maxScale
{
    _maxScale = maxScale;
    self.maximumZoomScale = _maxScale;
    [self recover];
}
-(void)set_minScale:(float)minScale
{
    _minScale = minScale;
    self.minimumZoomScale = _minScale;
    [self recover];
}
-(float)_nowScale
{
    return self.zoomScale;
}
-(void)moveToPointInImageView:(CGPoint)pointInImageView
{
    [self zoomToNewScale:self._nowScale pointInImageView:pointInImageView];
}
-(void)moveToPointInScroll:(CGPoint)pointInScroll//将scroll中pointInScroll处的像素放在中心点位置
{
    [self moveToPointInImageView:[self pointInScrollToPointInImageView:pointInScroll zoom:self._nowScale]];
}
-(void)moveToPointInPixel:(CGPoint)pointInPixel//将图片上pointInPixel处的像素放在中心点位置
{
    [self moveToPointInImageView:[self pointInPixelToPointInImageView:pointInPixel zoom:self._nowScale]];
}
-(void)zoomToNewScale:(float)newScale pointInImageView:(CGPoint)pointInImageView
{
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:pointInImageView];
    [self zoomToRect:zoomRect animated:YES];
}
-(void)zoomToNewScale:(float)newScale pointInScroll:(CGPoint) pointInScroll//以scroll中pointInScroll为中心点放大到newScale值
{
    [self zoomToNewScale:newScale pointInImageView:[self pointInScrollToPointInImageView:pointInScroll zoom:self._nowScale]];
}
-(void)zoomToNewScale:(float)newScale pointInPixel:(CGPoint) pointInPixel//以图片上的pointInPixel像素点为中心点，放大到newScale值
{
    [self zoomToNewScale:newScale pointInImageView:[self pointInPixelToPointInImageView:pointInPixel zoom:self._nowScale]];
}
//
-(void)handleDoubleTap:(UITapGestureRecognizer *)tapGesture
{
    float newScale = self._nowScale * _zoomStep;
    newScale = MIN(newScale, self._maxScale);
    [self zoomToNewScale:newScale pointInImageView:[tapGesture locationInView:tapGesture.view]];
}
-(void)handleSingleTap:(UITapGestureRecognizer *)tapGesture
{
    if(self._zoomDelegate)
    {
        CGPoint pointInImageView = [tapGesture locationInView:tapGesture.view];
        CGPoint pointInScroll = [self pointInImageViewToPointInScroll:pointInImageView zoom:self._nowScale];
        CGPoint pointInPixel = [self pointInImageViewToPointInPixel:pointInImageView zoom:self._nowScale];
        [self._zoomDelegate pick:self pointInImageView:pointInImageView pointInScroll:pointInScroll pointInPixel:pointInPixel];
    }
}

//
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    zoomRect.size.height = self.frame.size.height / scale;
    zoomRect.size.width  = self.frame.size.width  / scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    return zoomRect;
}
- (void)recover//恢复
{
    self.zoomScale = self._minScale;
    self.contentOffset = CGPointZero;
}

-(CGPoint)pointInPixelToPointInImageView:(CGPoint)pointInPixel zoom:(float)zoom
{
    CGPoint res = CGPointZero;
    UIImage * image = _imageView.image;
    if(image)
    {
        CGSize imageSize = image.size;
        CGSize imageViewSize = _imageView.frame.size;
        imageViewSize.width /= zoom;
        imageViewSize.height /= zoom;
        float dpi_x = imageSize.width / imageViewSize.width;
        float dpi_y = imageSize.height / imageViewSize.height;
        float dpi = MAX(dpi_x, dpi_y);
        if(dpi_x > dpi_y)
        {
            pointInPixel.y += (imageSize.width - imageSize.height) / 2;
        }
        else
        {
            pointInPixel.x += (imageSize.height - imageSize.width) / 2;
        }
        res.x = pointInPixel.x / dpi;
        res.y = pointInPixel.y / dpi;
    }
    return res;

}
-(CGPoint)pointInImageViewToPointInPixel:(CGPoint)pointInImageView zoom:(float)zoom
{
    CGPoint res = CGPointZero;
    UIImage * image = _imageView.image;
    if(image)
    {
        CGSize imageSize = image.size;
        CGSize imageViewSize = _imageView.frame.size;
        imageViewSize.width /= zoom;
        imageViewSize.height /= zoom;
        float dpi_x = imageSize.width / imageViewSize.width;
        float dpi_y = imageSize.height / imageViewSize.height;
        float dpi = MAX(dpi_x, dpi_y);
        res.x = pointInImageView.x * dpi;
        res.y = pointInImageView.y * dpi;
        if(dpi_x > dpi_y)
        {
            res.y -= (imageSize.width - imageSize.height) / 2;
        }
        else
        {
            res.x -= (imageSize.height - imageSize.width) / 2;
        }
    }
    return res;
}

-(CGPoint)pointInScrollToPointInImageView:(CGPoint)pointInScroll zoom:(float)zoom
{
    CGPoint res = CGPointZero;
    CGPoint offset = self.contentOffset;
    pointInScroll.x += offset.x;
    pointInScroll.y += offset.y;
    res.x = pointInScroll.x / zoom;
    res.y = pointInScroll.y / zoom;
    return res;
}
-(CGPoint)pointInImageViewToPointInScroll:(CGPoint)pointInImageView zoom:(float)zoom
{
    CGPoint res = CGPointZero;
    pointInImageView.x = pointInImageView.x * zoom;
    pointInImageView.y = pointInImageView.y * zoom;
    CGPoint offset = self.contentOffset;
    res.x = pointInImageView.x - offset.x;
    res.y = pointInImageView.y - offset.y;
    return res;
}




#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}
@end
