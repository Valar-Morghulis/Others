//
//  CEWaterfallViewCell_Normal.m
//  ShoppingInLZ
//
//  Created by MaYing on 14-5-16.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import "CEWaterfallViewCell_Normal.h"

@implementation CEWaterfallViewCell_Normal
@synthesize _descLabel;
@synthesize _imageView;
@synthesize _titleLabel;
@synthesize _preferentialImageView;

#define TitleFont [UIFont systemFontOfSize:15]
#define DescFont [UIFont systemFontOfSize:12]
-(id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier])
    {
        //
        self._imageView = [[[CTDownImageView alloc] initWithFrame:CGRectZero] autorelease];
        [self addSubview:self._imageView];
        [self._imageView set_defaultImage:[UIImage imageNamed:CEWaterfallViewCell_DefaultImage]];
        [self._imageView setImage:self._imageView._defaultImage];
        [self._imageView set_delegate:self];
        self._imageView._contentMode = UIViewContentModeScaleToFill;
        [self._imageView setUserInteractionEnabled:FALSE];
   
        //
        self._preferentialImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"preferential.png"]] autorelease];
        self._preferentialImageView.frame = CGRectMake(5, 5, 25, 25);
        [self addSubview:self._preferentialImageView];
        self._preferentialImageView.backgroundColor = [UIColor clearColor];
        self._preferentialImageView.hidden = TRUE;
        self._preferentialImageView.userInteractionEnabled = FALSE;
        //
        self._titleLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
        [self addSubview:self._titleLabel];
        self._titleLabel.backgroundColor = [UIColor clearColor];
        self._titleLabel.textColor = RGBA(114, 114, 114, 1);
        self._titleLabel.font = TitleFont;
        self._titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self._titleLabel.numberOfLines = 1;
        self._titleLabel.textAlignment = NSTextAlignmentLeft;
        //
        self._descLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
        [self addSubview:self._descLabel];
        self._descLabel.backgroundColor = [UIColor clearColor];
        self._descLabel.textColor = RGBA(146, 146, 146, 1);
        self._descLabel.font = DescFont;
        self._descLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self._descLabel.numberOfLines = 1;
        self._descLabel.textAlignment = NSTextAlignmentLeft;

    }
    return self;
}
-(void)dealloc
{
    self._titleLabel = 0;
    self._imageView = 0;
    self._descLabel = 0;
    [super dealloc];
}
- (void)prepareForReuse
{
    self._preferentialImageView.hidden = TRUE;//
    [self._imageView cancelLoad];
    [self._imageView setImage:self._imageView._defaultImage];
}
- (void)fillViewWithObject:(id)object
{
    [super fillViewWithObject:object];
    NSString * title = [object objectForKey:@"name"];
    NSString * desc = [object objectForKey:@"descript"];
    self._titleLabel.text = title;
    self._descLabel.text = desc;
    BOOL isPreferential = [[object objectForKey:@"isCheap"] boolValue];
    if(isPreferential)
    {
        self._preferentialImageView.hidden = FALSE;//
    }
    else
    {
        self._preferentialImageView.hidden = TRUE;//
    }
    //
    [self._imageView setImage:self._imageView._defaultImage];
    NSString * turl = [object objectForKey:@"imgUrl"];
    if(turl)
        turl = [CTUtility URLEncode:turl];
    NSString * imageUrl = [NSString stringWithFormat:@"%@%@",CTIMG_BASEURL,turl];
    
    NSString *md5Imagename = [CTUtility MD5Encode:imageUrl];
    UIImage * image = [CTUtility getCacheImageWithImageName:md5Imagename];
    if (!image)
    {
        [self._imageView loadImage:imageUrl];
    }
    else
    {
        [self._imageView setImage:image];
    }

}
+ (CGFloat)heightForViewWithObject:(id)object inColumnWidth:(CGFloat)columnWidth
{
    float imageHeight = 79;
    float textHeight = 57;
    return imageHeight + textHeight;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frame = self.frame;
    float imageHeight = 79;
    float disX = 5;
    float disY = 10;
    
    float imageOriginX = 0;
    float imageOriginY = 0;
    float imageWidth = frame.size.width;
    self._imageView.frame = CGRectMake(imageOriginX, imageOriginY, imageWidth, imageHeight);
    //
    //
    float titleOriginX = disX;
    float titleWidth = frame.size.width - titleOriginX - disX;
    float titleHeight = [@"test" sizeWithFont:TitleFont].height;
    float titleOriginY = imageOriginY + imageHeight + disY;
    self._titleLabel.frame = CGRectMake(titleOriginX, titleOriginY, titleWidth, titleHeight);
    //

    //
    float descOriginX = disX;
    float descWidth = frame.size.width - descOriginX - disX;
    float descHeight = [@"test" sizeWithFont:DescFont].height;
    float descOriginY = titleOriginY + titleHeight + 3;
    self._descLabel.frame = CGRectMake(descOriginX, descOriginY, descWidth, descHeight);
}
@end
