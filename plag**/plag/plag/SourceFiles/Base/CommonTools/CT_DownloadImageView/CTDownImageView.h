//
//  CTDownImageView.h
//  CBSWallet
//
//  Created by yaoyongping on 12-11-22.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APP_GlobeDefine.h"
#import "CommonToolsDefine.h"
#import "CTWebService.h"
@class CTDownImageView;

@protocol CTDownImageViewDelegate<NSObject>
-(void)afterDownImageViewSucceed:(CTDownImageView *) imageView image:(UIImage *)image url:(NSString *)url;
@end


@interface CTDownImageView : UIView<CTWebServiceDelegate>
{
   
	id<CTDownImageViewDelegate> _delegate;
    UIViewContentMode _contentMode;
    UIActivityIndicatorView *_activityView;
    UIImage * _defaultImage;
    UIImage * _emptyImage;
    UIImageView *_imageView;
     CTWebService * _webService;
    UIViewContentMode _emptyOrDefaultContentMode;
    NSString * _url;
    UIColor * _defaultColor;
}
@property(nonatomic,retain) NSString * _url;
@property(nonatomic,readonly) BOOL _isLoadingImage;
@property(nonatomic,assign)id<CTDownImageViewDelegate>_delegate;
@property(nonatomic,readwrite) UIViewContentMode _contentMode;
@property(nonatomic,readwrite) UIViewContentMode _emptyOrDefaultContentMode;
@property(nonatomic,retain) UIActivityIndicatorView *_activityView;
@property(nonatomic,retain) UIColor * _defaultColor;
@property(nonatomic,retain) UIImage * _defaultImage;
@property(nonatomic,retain) UIImage * _emptyImage;
@property(nonatomic,retain) UIImageView *_imageView;
@property(nonatomic,retain) CTWebService * _webService;

-(void)loadImage:(NSString *)imageUrl;
-(void)setImage:(UIImage *)img;
-(void)cancelLoad;

@end
