//
//  CEBaseViewController.m
//  Shopping_Mall
//
//  Created by yaoyongping on 13-9-24.
//
//

#import "CEBaseViewController.h"

@interface CEBaseViewController ()

@end

@implementation CEBaseViewController
{
}
@synthesize _data;

-(void)dealloc
{
    self._data = 0;
    [super dealloc];
}

#pragma mark CTDownImageViewDelegate
-(void)afterDownImageViewSucceed:(CTDownImageView *) imageView image:(UIImage *)image url:(NSString *)url
{
    NSString *imagename = [CTUtility MD5Encode:url];
    [CTUtility CachImageWithName:imagename img:image];
}

@end

