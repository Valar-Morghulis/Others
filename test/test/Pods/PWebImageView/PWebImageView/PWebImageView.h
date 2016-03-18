//
//  PWebImageView.h
//  CBSWallet
//
//  Created by yaoyongping on 12-11-22.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h> 

#import "WebImage.h"
extern NSString * PW_DEFAULT_EMPTY_IMAGE;//默认图片
extern UIColor * PW_DEFAULT_BACKGROUNDCOLOR;//默认背景
/**
 pod - targets - PWebImageView.a - Build Settings - Preprocessor Macros - 添加USED_DELEGATE_RETAIN_SET=1或者0来设置
 **
 如果USED_DELEGATE_RETAIN_SET 为0，需要手动设置 _delegate = 0;否则会有内存问题。
 **/
#ifndef USED_DELEGATE_RETAIN_SET
#define USED_DELEGATE_RETAIN_SET 1
#endif
@class PWebImageView;
@protocol PWebImageViewDelegate
-(void)afterImageLoaded:(PWebImageView *)imageView image:(UIImage *)image URL:(NSURL *)URL;

@end

@interface PWebImageView : UIView
{
    id <SDWebImageOperation> _operation;
    UIViewContentMode _contentMode;
    UIActivityIndicatorView *_activityView;
    UIImage * _defaultImage;
    UIImage * _emptyImage;
    UIImageView *_imageView;
    UIViewContentMode _emptyOrDefaultContentMode;
    UIColor * _defaultColor;
    id<PWebImageViewDelegate> _delegate;
#if USED_DELEGATE_RETAIN_SET
    BOOL _isDelegateRetained;
#endif
}
@property(nonatomic,assign)  id<PWebImageViewDelegate> _delegate;

//
@property(nonatomic, retain) id <SDWebImageOperation> _operation;

@property(nonatomic,readonly) BOOL _isLoadingImage;
@property(nonatomic,readwrite) UIViewContentMode _contentMode;
@property(nonatomic,readwrite) UIViewContentMode _emptyOrDefaultContentMode;
@property(nonatomic,retain) UIActivityIndicatorView *_activityView;
@property(nonatomic,retain) UIColor * _defaultColor;
@property(nonatomic,retain) UIImage * _defaultImage;
@property(nonatomic,retain) UIImage * _emptyImage;
@property(nonatomic,retain) UIImageView *_imageView;

-(void)loadImage:(NSString *)imageUrl;
-(void)loadImage:(NSString *)imageUrl options:(SDWebImageOptions)options;
-(void)setImage:(UIImage *)img;
-(void)cancelLoad;

+(UIImage *)cachedImageWidthUrl:(NSString *)url;//如果在cache中存在，将返回image,否则返回0
@end
