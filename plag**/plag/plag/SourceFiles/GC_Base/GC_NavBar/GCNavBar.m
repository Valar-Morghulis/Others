//
//  GCNavBar.m
//  ProjectReports
//
//  Created by Thinkfer on 14/11/16.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//



#import "GCNavBar.h"


@implementation GCNavBar
@synthesize _delegate;
@synthesize _backButton;

@synthesize _titleLabel;
@synthesize _rightButton;

-(void)dealloc
{
    self._rightButton = 0;
    self._titleLabel = 0;
  
    self._backButton = 0;
    [super dealloc];
}
-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        float backOriginX = 0;
        float backHeight =frame.size.height;
        float backWidth = backHeight + 13;
        float backOriginY = 0;
        self._backButton = [[[UIButton alloc] initWithFrame:CGRectMake(backOriginX, backOriginY, backWidth, backHeight)] autorelease];
        [self addSubview:self._backButton];
        [self._backButton addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self._backButton setImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
        //
        float rightButtonWidth = backWidth;
        float rightButtonOiginY = backOriginY;
        float rightButtonHeight = backHeight;
        float rightButtonOriginX = frame.size.width - rightButtonWidth - backOriginX;
        self._rightButton = [[[UIButton alloc] initWithFrame:CGRectMake(rightButtonOriginX, rightButtonOiginY, rightButtonWidth, rightButtonHeight)] autorelease];
        [self addSubview:self._rightButton];
        [self._rightButton addTarget:self action:@selector(rightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
        //
        float titleOrignX = backOriginX + backWidth + 5;
        float titleOriginY = 0;
        float titleWidth = frame.size.width - titleOrignX * 2;
        float titleHeight = frame.size.height;
        self._titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(titleOrignX, titleOriginY, titleWidth, titleHeight)] autorelease];
        [self addSubview:self._titleLabel];
        self._titleLabel.backgroundColor = [UIColor clearColor];
        self._titleLabel.font = [UIFont systemFontOfSize:17];
        self._titleLabel.textAlignment = NSTextAlignmentCenter;
        self._titleLabel.textColor = RGBA(102, 102, 102, 1);
        self._titleLabel.numberOfLines = 1;
        self._titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        self.backgroundColor = [UIColor whiteColor];//RGBA(244, 245, 247, 1);
        
    }
    return self;
}
-(void)setBackButtonImage:(UIImage *) normalImage highlightImage:(UIImage *)highlightImage
{
    [self._backButton setImage:normalImage forState:UIControlStateNormal];
    [self._backButton setImage:highlightImage forState:UIControlStateHighlighted];
}

-(void)setRightButtonImage:(UIImage *) normalImage highlightImage:(UIImage *)highlightImage
{
    [self._rightButton setImage:normalImage forState:UIControlStateNormal];
    [self._rightButton setImage:highlightImage forState:UIControlStateHighlighted];
}

-(void)setTitleLabelText:(NSString *)title
{
    self._titleLabel.text = title;
}

-(void)backButtonClicked
{
    if(self._delegate)
    {
        [self._delegate backButtonClicked:self];
    }
}
-(void)rightButtonClicked
{
    if(self._delegate)
    {
        [self._delegate rightButtonClicked:self];
    }
}

@end
