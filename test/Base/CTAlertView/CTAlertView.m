//
//  CTAlertView.m
//  SMAirlineTickets
//
//  Created by yaoyongping on 12-7-13.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CTAlertView.h"

NSString * CTALERTVIEW_BACKGROUNDIMAGE  =  @"bg_alert.png";
NSString * CTALERTVIEW_GRAYBUTTONIMAGE  =  @"btn_alert_gray.png";
NSString * CTALERTVIEW_ACTIONBUTTONIMAGE  =  @"btn_alert_action.png";
NSString * CTALERTVIEW_NORMALBUTTONIMAGE  =  @"btn_alert_normal.png";
UIColor * CTALERTVIEW_TEXTCOLOR  =  0;

@interface CTAlertView()
-(void)changeAlertUI;
@end

@implementation CTAlertView



- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id /*<UIAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
    if(!CTALERTVIEW_TEXTCOLOR)
    {
        CTALERTVIEW_TEXTCOLOR  =  [UIColor colorWithRed:85.0/255.0 green:85.0/255.0 blue:85.0/255.0 alpha:1];
    }
    va_list argList;
    va_start(argList, otherButtonTitles);
    [super initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles,va_arg(argList, NSString *), nil];
    va_end(argList);
    return self;
}

-(void)layoutSubviews
{
    [self changeAlertUI];
}


-(void)changeAlertUI
{
    UIImage * backgroundImage  =  [UIImage imageNamed:[[NSBundle mainBundle] pathForResource:[@"CTAlertView.bundle/images/" stringByAppendingPathComponent:CTALERTVIEW_BACKGROUNDIMAGE] ofType:0]];
    
    UIImage * grayButtonImage  =  [UIImage imageNamed:[[NSBundle mainBundle] pathForResource:[@"CTAlertView.bundle/images/" stringByAppendingPathComponent:CTALERTVIEW_GRAYBUTTONIMAGE] ofType:0]];

    UIImage * actionButtonImage  =  [UIImage imageNamed:[[NSBundle mainBundle] pathForResource:[@"CTAlertView.bundle/images/" stringByAppendingPathComponent:CTALERTVIEW_ACTIONBUTTONIMAGE] ofType:0]];

    UIImage * normalButtonImage = [UIImage imageNamed:[[NSBundle mainBundle] pathForResource:[@"CTAlertView.bundle/images/" stringByAppendingPathComponent:CTALERTVIEW_NORMALBUTTONIMAGE] ofType:0]];

    
    
    int i = 0;
	UIColor *textColor  =  CTALERTVIEW_TEXTCOLOR;
	for (UIView *v in [self subviews])
    {
        if ([v class]   ==  [UIImageView class])
        {
            UIImageView* imageView  =  (UIImageView *)v;
            
            CGRect rect  =  imageView.frame;
            rect.origin.x  -=  (320-imageView.frame.size.width)/2;
            rect.origin.y  =  -20;
            rect.size.height  +=  30;
            int x  =  2*rect.origin.x;
            if (x<0) 
            {
                x  =  -x;
            }
            
            rect.size.width  +=  x; 
            
            if (rect.size.width > 320) {
                rect.size.width  =  320;
            }            
            imageView.frame  =  rect;
            UIImage *bg_image  =  backgroundImage;
            bg_image = [bg_image stretchableImageWithLeftCapWidth:bg_image.size.width/2 topCapHeight:bg_image.size.height/2];
            [imageView setImage:bg_image];            
        }
        
        if ([v isKindOfClass:[UIButton class]]) {
            UIImage *btn_bg  =  grayButtonImage;
            UIImage *btn_bg_action  =  actionButtonImage;
            UIColor *btn_title_color = [UIColor colorWithRed:118.0f/255.0f green:118.0f/255.0f blue:118.0f/255.0f alpha:1];
            if (i  == 0) {
                btn_title_color = [UIColor whiteColor];
                btn_bg = normalButtonImage;
                btn_bg_action = actionButtonImage;
            }
            btn_bg = [btn_bg stretchableImageWithLeftCapWidth:btn_bg.size.width/2 topCapHeight:0];
            btn_bg_action = [btn_bg_action stretchableImageWithLeftCapWidth:btn_bg_action.size.width/2 topCapHeight:0];
            
            UIButton* btn  =  (UIButton *)v;
            
            [btn setBackgroundImage:btn_bg forState:UIControlStateNormal];
            [btn setBackgroundImage:btn_bg_action forState:UIControlStateHighlighted];
            
            [btn setTitleColor:btn_title_color forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
            btn.titleLabel.shadowColor  =  [UIColor clearColor];
            [btn.titleLabel setShadowOffset:CGSizeMake(0, 0)];            
            i++;
        }
        else if([v isKindOfClass:NSClassFromString(@"UIThreePartButton")])
        {
            UIImage *btn_bg = grayButtonImage;
            UIImage *btn_bg_action = actionButtonImage;
            UIColor *btn_title_color = [UIColor colorWithRed:118.0f/255.0f green:118.0f/255.0f blue:118.0f/255.0f alpha:1];
            if (i  == 0) {
                btn_title_color = [UIColor whiteColor];
                btn_bg = normalButtonImage;
                btn_bg_action = actionButtonImage;
            }
            btn_bg = [btn_bg stretchableImageWithLeftCapWidth:btn_bg.size.width/2 topCapHeight:btn_bg.size.height/2];
            btn_bg_action = [btn_bg_action stretchableImageWithLeftCapWidth:btn_bg_action.size.width/2 topCapHeight:btn_bg.size.height/2];

            
            if ([v respondsToSelector:@selector(setBackgroundImage:)]) {
                
                [v setBackgroundImage:btn_bg];
                
                if ([v respondsToSelector:@selector(setTitleColor:forState:)]) {
                    [v setTitleColor:btn_title_color forState:UIControlStateNormal];
                    [v setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
                }
                
                if ([v respondsToSelector:@selector(setShadowColor:forState:)]) {
                    [v setShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
                }
                
                if ([v respondsToSelector:@selector(setFont:)]) {
                    [v setFont:[UIFont boldSystemFontOfSize:17]];
                }
                
                if ([v respondsToSelector:@selector(setShadowColor:)]) {
                    [v setShadowColor:[UIColor clearColor]];
                }
                
                i++;
            }

        }
        else if ([v isKindOfClass:[UILabel class]]) {
            
            UILabel *lbl = (UILabel *)v;
            [lbl setTextColor:textColor];
            [lbl setShadowOffset:CGSizeMake(0, 0)];
            [lbl setShadowColor:[UIColor clearColor]];
            //[self bringSubviewToFront:lbl];
        }
    }
}



@end
