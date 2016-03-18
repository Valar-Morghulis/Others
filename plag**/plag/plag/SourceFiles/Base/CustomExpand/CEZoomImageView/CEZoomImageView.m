//
//  CEZoomImageView.m
//  BIPT_OA
//
//  Created by Thinkfer on 14-3-11.
//  Copyright (c) 2014年 Thinkfer. All rights reserved.
//

#import "CEZoomImageView.h"
#define DefaultZoomStep 2 //放大倍数
#define DefaultZoomCount 1//放大次数
@implementation CEZoomImageView
@synthesize _zoomCount;
@synthesize _zoomStep;

@synthesize _imageView;
@synthesize _imageViewDelegate;

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _zoomStep = DefaultZoomStep;
        _zoomCount = DefaultZoomCount;
        
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.bouncesZoom = TRUE;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self._imageView = [[[CTDownImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)] autorelease];
        self._imageView._contentMode = UIViewContentModeScaleAspectFill;
        
        [self._imageView set_defaultImage:[UIImage imageNamed:CEZoomImageView_DEFAULT_IMAGE_NAME]];
        [self._imageView setImage:self._imageView._defaultImage];
        self._imageView.userInteractionEnabled = TRUE;
        [self addSubview:self._imageView];
        // add gesture recognizers to the image view
        UITapGestureRecognizer *singleTap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)] autorelease];
        UITapGestureRecognizer *doubleTap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)] autorelease];
        
        
        [doubleTap setNumberOfTapsRequired:2];
        [singleTap requireGestureRecognizerToFail:doubleTap];
        [self addGestureRecognizer:singleTap];
        [self addGestureRecognizer:doubleTap];
        self.contentSize = self._imageView.frame.size;
        [self setMaxMinZoomScalesForCurrentBounds];
        [self setZoomScale:self.minimumZoomScale animated:FALSE];
    }
    return self;
}
-(void)dealloc
{
    self._imageView = 0;
     [super dealloc];
}
-(void)set_zoomCount:(float)zoomCount
{
    _zoomCount = zoomCount;
    [self recoverFromResizing];
    [self setMaxMinZoomScalesForCurrentBounds];
    [self setZoomScale:self.minimumZoomScale animated:FALSE];
}
-(void)set_zoomStep:(float)zoomStep
{
    _zoomStep = zoomStep;
    [self recoverFromResizing];
    [self setMaxMinZoomScalesForCurrentBounds];
    [self setZoomScale:self.minimumZoomScale animated:FALSE];
}
- (void)setFrame:(CGRect)frame
{
    BOOL sizeChanging = !CGSizeEqualToSize(frame.size, self.frame.size);
    
    if (sizeChanging)
    {
        [self prepareToResize];
    }
    
    [super setFrame:frame];
    
    if (sizeChanging)
    {
        [self recoverFromResizing];
    }
}

#pragma mark - Gestures
#pragma mark -

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer
{
    if (self._imageViewDelegate)
    {
        [self._imageViewDelegate imageViewDidSingleTap:self];
    }
}

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer
{
    if(self._imageView._isLoadingImage)
    {
        return;
    }
    
    //
    if (self.zoomScale == self.maximumZoomScale)
    {
        // jump back to minimum scale
        [self updateZoomScaleWithGesture:gestureRecognizer newScale:self.minimumZoomScale];
    }
    else
    {
        // double tap zooms in
        CGFloat newScale = MIN(self.zoomScale * _zoomStep, self.maximumZoomScale);
        [self updateZoomScaleWithGesture:gestureRecognizer newScale:newScale];
    }
    
    if (self._imageViewDelegate)
    {
        [self._imageViewDelegate imageViewDidDoubleTap:self];
    }
}
- (CGPoint)adjustPointIntoImageView:(CGPoint)center {
    BOOL contains = CGRectContainsPoint(self._imageView.frame, center);
    
    if (!contains) {
        center.x = center.x / self.zoomScale;
        center.y = center.y / self.zoomScale;
        
        // adjust center with bounds and scale to be a point within the image view bounds
        CGRect imageViewBounds = self._imageView.bounds;
        
        center.x = MAX(center.x, imageViewBounds.origin.x);
        center.x = MIN(center.x, imageViewBounds.origin.x + imageViewBounds.size.height);
        
        center.y = MAX(center.y, imageViewBounds.origin.y);
        center.y = MIN(center.y, imageViewBounds.origin.y + imageViewBounds.size.width);
        
        return center;
    }
    
    return CGPointZero;
}

#pragma mark - Support Methods
#pragma mark -

- (void)updateZoomScale:(CGFloat)newScale {
    CGPoint center = CGPointMake(self._imageView.bounds.size.width/ 2.0, self._imageView.bounds.size.height / 2.0);
    [self updateZoomScale:newScale withCenter:center];
}

- (void)updateZoomScaleWithGesture:(UIGestureRecognizer *)gestureRecognizer newScale:(CGFloat)newScale
{
    CGPoint center = [gestureRecognizer locationInView:gestureRecognizer.view];
    [self updateZoomScale:newScale withCenter:center];
}

- (void)updateZoomScale:(CGFloat)newScale withCenter:(CGPoint)center {

    if (self.zoomScale != newScale) {
        CGRect zoomRect = [self zoomRectForScale:newScale withCenter:center];
        [self zoomToRect:zoomRect animated:YES];
        NSLog(@"%f %f %f",self.minimumZoomScale,self.zoomScale,self.maximumZoomScale);
    }
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {

    CGRect zoomRect;
    
    // the zoom rect is in the content view's coordinates.
    zoomRect.size.width = self.frame.size.width / scale;
    zoomRect.size.height = self.frame.size.height / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}



- (void)setMaxMinZoomScalesForCurrentBounds {
    // calculate minimum scale to perfectly fit image width, and begin at that scale
    CGSize boundsSize = self.bounds.size;
    
    CGFloat minScale = 0.25;
    
    if (self._imageView.bounds.size.width > 0.0 && self._imageView.bounds.size.height > 0.0)
    {
        // calculate min/max zoomscale
        CGFloat xScale = boundsSize.width  / self._imageView.bounds.size.width;    // the scale needed to perfectly fit the image width-wise
        CGFloat yScale = boundsSize.height / self._imageView.bounds.size.height;   // the scale needed to perfectly fit the image height-wise
        
        xScale = MIN(1, xScale);
        yScale = MIN(1, yScale);
        
        minScale = MIN(xScale, yScale);
    }
    CGFloat maxScale = minScale * pow(_zoomStep , _zoomCount);
    self.maximumZoomScale = maxScale;
    self.minimumZoomScale = minScale;
}

- (void)prepareToResize {
    CGPoint boundsCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    _pointToCenterAfterResize = [self convertPoint:boundsCenter toView:self._imageView];
    
    _scaleToRestoreAfterResize = self.zoomScale;
    
    // If we're at the minimum zoom scale, preserve that by returning 0, which will be converted to the minimum
    // allowable scale when the scale is restored.
    if (_scaleToRestoreAfterResize <= self.minimumZoomScale + FLT_EPSILON)
        _scaleToRestoreAfterResize = 0;
}

- (void)recoverFromResizing
{
    [self setMaxMinZoomScalesForCurrentBounds];
    
    // Step 1: restore zoom scale, first making sure it is within the allowable range.
    CGFloat maxZoomScale = MAX(self.minimumZoomScale, _scaleToRestoreAfterResize);
    self.zoomScale = MIN(self.maximumZoomScale, maxZoomScale);
    
    // Step 2: restore center point, first making sure it is within the allowable range.
    
    // 2a: convert our desired center point back to our own coordinate space
    CGPoint boundsCenter = [self convertPoint:_pointToCenterAfterResize fromView:self._imageView];
    
    // 2b: calculate the content offset that would yield that center point
    CGPoint offset = CGPointMake(boundsCenter.x - self.bounds.size.width / 2.0,
                                 boundsCenter.y - self.bounds.size.height / 2.0);
    
    // 2c: restore offset, adjusted to be within the allowable range
    CGPoint maxOffset = [self maximumContentOffset];
    CGPoint minOffset = [self minimumContentOffset];
    
    CGFloat realMaxOffset = MIN(maxOffset.x, offset.x);
    offset.x = MAX(minOffset.x, realMaxOffset);
    
    realMaxOffset = MIN(maxOffset.y, offset.y);
    offset.y = MAX(minOffset.y, realMaxOffset);
    
    self.contentOffset = offset;
}

- (CGPoint)maximumContentOffset {
    CGSize contentSize = self.contentSize;
    CGSize boundsSize = self.bounds.size;
    return CGPointMake(contentSize.width - boundsSize.width, contentSize.height - boundsSize.height);
}

- (CGPoint)minimumContentOffset {
    return CGPointZero;
}

#pragma mark - UIScrollViewDelegate Methods
#pragma mark -

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self._imageView;
}
@end
