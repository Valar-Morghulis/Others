//
//  CENavBarItemView.m
//  ShoppingMall
//
//  Created by MaYing on 13-11-15.
//
//

#import "CENavBarItemView.h"

@implementation CENavBarItemView
@synthesize _data;
@synthesize _delegate;


-(void)dealloc
{
    self._data = 0;
    [super dealloc];
}
-(void)initlizeWithFrame:(CGRect)frame
{
    self.frame = frame;
}

-(CENavBarItemView *)deepCopy
{
    return [[[[self class] alloc] init] autorelease];
}
-(void)set_data:(NSDictionary *)data
{
    if(_data != data)
    {
        if(_data)
        {
            [_data release];
        }
        _data = data;
        if(_data)
        {
            [_data retain];
            //
            [self parseData];
        }
    }
}
-(CGRect)autoAdjustFrame:(CGRect)originFrame data:(NSDictionary *)data
{
    return originFrame;
}
-(void)parseData
{
    
}
-(void)setSelected:(BOOL)animated
{
    if(self._delegate && animated)
    {
        [self._delegate itemSelected:self data:self._data];
    }
}
-(void)setUnselected:(BOOL)animated
{
    if(self._delegate && animated)
    {
        [self._delegate itemUnselected:self data:self._data];
    }
}
#pragma mark CTDownImageViewDelegate
-(void)afterDownImageViewSucceed:(CTDownImageView *) imageView image:(UIImage *)image url:(NSString *)url
{
    NSString *imagename = [CTUtility MD5Encode:url];
    [CTUtility CachImageWithName:imagename img:image];
}
@end
