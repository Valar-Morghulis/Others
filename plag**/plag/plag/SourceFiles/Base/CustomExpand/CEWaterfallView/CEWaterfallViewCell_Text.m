//
//  CEWaterfallViewCell_Text.m
//  ShoppingInLZ
//
//  Created by MaYing on 14-5-16.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import "CEWaterfallViewCell_Text.h"

#define MARGIN_X 10.0 //x缩进
#define MARGIN_Y 10.0 //y缩进
#define LABLE_FONT [UIFont systemFontOfSize:12]
@implementation CEWaterfallViewCell_Text
@synthesize _textLabel;
-(id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier])
    {
        self._textLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
        [self addSubview:self._textLabel];
        
        self._textLabel.backgroundColor = [UIColor clearColor];
        self._textLabel.textColor = RGBA(251, 61, 11, 1);
        self._textLabel.font = LABLE_FONT;
        self._textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self._textLabel.numberOfLines = 0;
        self._textLabel.textAlignment = NSTextAlignmentLeft;
    }
    return self;
}
-(void)dealloc
{
    self._textLabel = 0;
    [super dealloc];
}
- (void)prepareForReuse
{
    self._textLabel.text = @"";
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frame = self.frame;
    float originX = MARGIN_X;
    float width = frame.size.width - originX - MARGIN_X;
    float originY = MARGIN_Y;
    float height = frame.size.height - originY - MARGIN_Y;
    self._textLabel.frame = CGRectMake(originX, originY, width, height);
}
- (void)fillViewWithObject:(id)object
{
    [super fillViewWithObject:object];
    self._textLabel.text = [self.object objectForKey:@"title"];
    [self._textLabel sizeToFit];
}
+ (CGFloat)heightForViewWithObject:(id)object inColumnWidth:(CGFloat)columnWidth
{
    CGFloat height = 0.0;
    height += MARGIN_Y;
    
    NSString *title = [object objectForKey:@"title"];
#if 0
    CGFloat width = columnWidth - MARGIN_X * 2;
    CGSize labelSize = CGSizeZero;
    labelSize = [title sizeWithFont:LABLE_FONT constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    height += labelSize.height;
#else
    float numPerCol = 9;//每行9汉字
    float heightPerCol = 15;//每行高度15
    float colNum_f = [title length] / numPerCol;
    int colNum_i = (int)colNum_f;
    colNum_i = (colNum_f - colNum_i) > 0 ? colNum_i + 1 : colNum_i;
    
    height += colNum_i * heightPerCol;
#endif
    
    height += MARGIN_Y;
    return height;
}


@end
