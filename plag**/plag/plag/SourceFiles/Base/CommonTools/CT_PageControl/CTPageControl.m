//
//  CTPageControl.m
//  GIIBank1.0
//
//  Created by BIPT mac1 on 12-2-22.
//  Copyright 2012 BIPT. All rights reserved.
//

#import "CTPageControl.h"
#import "CTUtility.h"
#import "CTDevice.h"
@implementation CTPageControl
@synthesize activeImage;
@synthesize inactiveImage;

-(id)initWithFrame:(CGRect)frame{
	if (self = [super initWithFrame:frame])
    {
		[self setHidesForSinglePage:YES];
		[self setBackgroundColor:[UIColor clearColor]];
		[self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
		[self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
		[self setUserInteractionEnabled:NO];
        if(IS_IOS7_OR_LATER)
        {
            self.pageIndicatorTintColor = CTPAGECONTROL_INACTIVECOLOR;
            self.currentPageIndicatorTintColor = CTPAGECONTROL_ACTIVECOLOR;
        }
    
	}
	return self;
}

-(void)updateDots
{ // 更新显示所有的点按钮

    if (!self.activeImage)
    {
        self.activeImage = [UIImage imageNamed:CTPAGECONTROL_ACTIVEIMAGE];
    }
    if (!self.inactiveImage)
    {
        self.inactiveImage = [UIImage imageNamed:CTPAGECONTROL_INACTIVEIMAGE];
    }
    for (int i = 0; i < [self.subviews count]; i++)
    {
        UIImageView* dot = [self.subviews objectAtIndex:i];
        if ([dot isKindOfClass:[UIImageView class]]) {
            
            if (i == self.currentPage)
            {
                dot.image = self.activeImage;
            }
            else
            {
                dot.image = self.inactiveImage;
            }
        }
    }

}

-(void)setCurrentPage:(NSInteger)page{
	[super setCurrentPage:page];
	[self updateDots];
}

-(void)updateCurrentPageIndex:(int)page{
    [self setCurrentPage:page];
    [self updateDots];
}

-(void)setNumberOfPages:(NSInteger)count{
	[super setNumberOfPages:count];
	[self updateDots];
}

-(void)dealloc
{
	[self.activeImage release];
	[self.inactiveImage release];
	[super dealloc];
}

@end

