//
//  CEMoveTableViewCell.m
//  guangCity
//
//  Created by MaYing on 13-12-19.
//
//

#import "CEMoveTableViewCell.h"

@implementation CEMoveTableViewCell

@synthesize _imageView;
@synthesize _titleLabel;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        float imageViewOriginX = 20;
        float imageViewHeight = 24;
        float imageViewOriginY = (DEFAULT_CEMAIN_SETTINGLIST_CELL_HEIGHT - imageViewHeight) / 2;
        float imageViewWidth = imageViewHeight;
        
        self._imageView = [[[CTDownImageView alloc] initWithFrame:CGRectMake(imageViewOriginX, imageViewOriginY, imageViewWidth, imageViewHeight)] autorelease];
        [self addSubview:self._imageView];
        
        self._imageView._defaultImage = [UIImage imageNamed:DEFAULT_CE_TABLELIST_CELL_DEFAULT_IMAGE];
        [self._imageView setImage:self._imageView._defaultImage];
        self._imageView._delegate = self;
        float disX = 15;
        
        float labelOriginX = imageViewOriginX + imageViewWidth + disX;
        float labelOriginY = imageViewOriginY;
        float labelHeight = imageViewHeight;
        float labelWidth = self.frame.size.width - labelOriginX;
        self._titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(labelOriginX, labelOriginY, labelWidth, labelHeight)] autorelease];
        [self addSubview:self._titleLabel];
        
        self._titleLabel.font = [UIFont systemFontOfSize:14];
        self._titleLabel.textColor = [UIColor blackColor];
        self._titleLabel.backgroundColor = [UIColor clearColor];
        self._titleLabel.textAlignment = NSTextAlignmentLeft;
        //背景颜色
        self.backgroundView.backgroundColor = DEFAULT_CE_MOVETABLELIST_CELL_COLOR_NORMAL;
        self.selectedBackgroundView.backgroundColor = DEFAULT_CE_MOVETABLELIST_CELL_COLOR_SELECTED;
        
        self._titleLabel.hidden = TRUE;
        self._imageView.hidden = TRUE;
        
        CGRect coverViewFrame = {0,0,self.frame.size.width,DEFAULT_CEMAIN_SETTINGLIST_CELL_HEIGHT};
        _coverView = [[UIView alloc] initWithFrame:coverViewFrame];
        [self addSubview:_coverView];
        [_coverView release];
        _coverView.backgroundColor = self.backgroundView.backgroundColor;
    }
    return self;
}
-(void)dealloc
{
    self._titleLabel = 0;
    self._imageView = 0;
    [super dealloc];
}
-(void)changeState:(BOOL)isMove
{
    self._titleLabel.hidden = TRUE;
    self._imageView.hidden = TRUE;
    
    if(self._data)
    {
        BOOL isSplit = [[self._data objectForKey:@"isSplit"] boolValue];
        BOOL isUsed = [[self._data objectForKey:@"isUsed"] boolValue];
        if(!isSplit)
        {
            
            //背景颜色
            UIColor * backgroundColor1 = DEFAULT_CE_MOVETABLELIST_CELL_COLOR_NORMAL;
            UIColor * backgroundColor2 = DEFAULT_CE_MOVETABLELIST_CELL_COLOR_SELECTED;
            if(!isUsed)
            {
                backgroundColor1 = DEFAULT_CE_MOVETABLELIST_UNUSED_COLOR_NORMAL;
                backgroundColor2 = DEFAULT_CE_MOVETABLELIST_UNUSED_COLOR_SELECTED;
            }
            self.backgroundView.backgroundColor = backgroundColor1;
            self.selectedBackgroundView.backgroundColor = backgroundColor2;
            if(!isMove)
            {
                self._titleLabel.hidden = FALSE;
                self._imageView.hidden = FALSE;
            }
        }
        else
        {
            self.backgroundView.backgroundColor = DEFAULT_CE_MOVETABLELIST_SPLIT_COLOR_NORMAL;
            self.selectedBackgroundView.backgroundColor = DEFAULT_CE_MOVETABLELIST_SPLIT_COLOR_SELECTED;
        }
    }//fi
    
}
-(void)parseData
{
    [self changeState:FALSE];
    if(self._data)
    {
        BOOL isSplit = [[self._data objectForKey:@"isSplit"] boolValue];
        //BOOL isUsed = [[self.data objectForKey:@"isUsed"] boolValue];
        if(!isSplit)
        {
            [self setUserInteractionEnabled:TRUE];
            NSString * title = [self._data objectForKey:@"title"];
            [self._titleLabel setText:title];
            
            [self._imageView setImage:self._imageView._defaultImage];
            NSString * picImageName = [self._data objectForKey:@"commonImage"];
            UIImage *image = [UIImage imageNamed:picImageName];
            if(!image)
            {
                NSString * imageUrl = picImageName;
                /*
                 NSString * imageUrl = [configDic objectForKey:@"image_url"];
                 imageUrl =[imageUrl stringByAppendingPathComponent:goodsImageName];
                 */
                NSString *md5Imagename = [CTUtility MD5Encode:imageUrl];
                image=[CTUtility getCacheImageWithImageName:md5Imagename];
                if (!image)
                {
                    [self._imageView loadImage:imageUrl];
                }
                else
                {
                    [self._imageView setImage:image];
                }
            }
            else
            {
                [self._imageView setImage:image];
            }
        }//fi
        else
        {
            [self setUserInteractionEnabled:FALSE];
        }
    }
}
-(void)prepareForMove
{
    [self changeState:TRUE];
}
-(void)prepareForStill
{
    [self changeState:FALSE];
}
-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    UIColor * color = 0;
    if(selected)
    {
        color = self.selectedBackgroundView.backgroundColor;
    }
    else
    {
        color = self.backgroundView.backgroundColor;
    }
    _coverView.backgroundColor = color;
}
-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    UIColor * color = 0;
    if(selected)
    {
        color = self.selectedBackgroundView.backgroundColor;
    }
    else
    {
        color = self.backgroundView.backgroundColor;
    }
    _coverView.backgroundColor = color;

}
@end
