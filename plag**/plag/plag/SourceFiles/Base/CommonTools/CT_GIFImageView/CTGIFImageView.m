//
//  CTGIFImageView.m
//  TestGIF
//
//  Created by shichangone on 11-7-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CTGIFImageView.h"
#import <ImageIO/ImageIO.h>

@implementation CTGIFImageFrame
@synthesize image = _image;
@synthesize duration = _duration;

- (void)dealloc
{
    [_image release];
    [super dealloc];
}

@end

@interface CTGIFImageView ()

- (void)resetTimer;

- (void)showNextImage;

@end

@implementation CTGIFImageView
@synthesize imageFrameArray = _imageFrameArray;
@synthesize timer = _timer;
-(id)initWithGifFileName:(NSString*) gifFileName
{
    if(self = [super init])
    {
        NSString* filePath = [[NSBundle mainBundle] pathForResource:gifFileName ofType:nil];
        NSData* imageData = [NSData dataWithContentsOfFile:filePath];
        [self setData:imageData];
    }
    return self;
}
-(id)initWithFrame:(CGRect) frame andGifFileName:(NSString*) gifFileName
{
    if(self = [super initWithFrame:frame])
    {
        NSString* filePath = [[NSBundle mainBundle] pathForResource:gifFileName ofType:nil];
        NSData* imageData = [NSData dataWithContentsOfFile:filePath];
        [self setData:imageData];

    }
    return self;
}
-(void)setImageFrameArray:(NSArray *)imageFrameArray
{
    if(_imageFrameArray != imageFrameArray)
    {
        if(_imageFrameArray)
        {
            [_imageFrameArray release];
            _imageFrameArray = 0;
        }
        if(imageFrameArray)
        {
            _imageFrameArray = [imageFrameArray retain];
        }
    }
    //
    if(_imageFrameArray && [_imageFrameArray count] > 0)
    {
        [self resetTimer];
        _currentImageIndex = -1;
        [self showNextImage];
    }
}
- (void)dealloc
{
    [self resetTimer];
    [_imageFrameArray release];
    [_timer release];
    [super dealloc];
}

- (void)resetTimer {
    if (_timer && _timer.isValid) {
        [_timer invalidate];
    }
    
    self.timer = nil;
}
- (void)setData:(NSData *)imageData {
    if (!imageData) {
        return;
    }
    [self resetTimer];
    
    CGImageSourceRef source = CGImageSourceCreateWithData((CFDataRef)imageData, NULL);
    size_t count = CGImageSourceGetCount(source);
    
    NSMutableArray* tmpArray = [NSMutableArray array];
    
    for (size_t i = 0; i < count; i++) {
        CTGIFImageFrame* gifImage = [[[CTGIFImageFrame alloc] init] autorelease];
        
        CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
        gifImage.image = [UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
        
        NSDictionary* frameProperties = [(NSDictionary*)CGImageSourceCopyPropertiesAtIndex(source, i, NULL) autorelease];
        gifImage.duration = [[[frameProperties objectForKey:(NSString*)kCGImagePropertyGIFDictionary] objectForKey:(NSString*)kCGImagePropertyGIFDelayTime] doubleValue];
        gifImage.duration = MAX(gifImage.duration, 0.01);
        
        [tmpArray addObject:gifImage];
        
        CGImageRelease(image);
    }
    CFRelease(source);
    
    self.imageFrameArray = nil;
    if (tmpArray.count > 1) {
        self.imageFrameArray = tmpArray;
        _currentImageIndex = -1;
        [self showNextImage];
    } else {
        self.image = [UIImage imageWithData:imageData];
    }
}

- (void)setImage:(UIImage *)image {
    [super setImage:image];
    [self resetTimer];
    self.imageFrameArray = nil;
}

- (void)showNextImage {
    _currentImageIndex = (++_currentImageIndex) % _imageFrameArray.count;
    CTGIFImageFrame* gifImage = [_imageFrameArray objectAtIndex:_currentImageIndex];
    [super setImage:[gifImage image]];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:gifImage.duration target:self selector:@selector(showNextImage) userInfo:nil repeats:NO];
}

@end
