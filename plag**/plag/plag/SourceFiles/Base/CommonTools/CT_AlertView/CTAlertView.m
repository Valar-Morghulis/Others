//
//  CTAlertView.m
//  SMAirlineTickets
//
//  Created by yaoyongping on 12-7-13.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CTAlertView.h"



@interface CTAlertView(private)
-(void)changeAlertUI;
@end

@implementation CTAlertView
static int _alertviewIndex=0;



- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id /*<UIAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
    [super initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickAlert:) name:CTDismissWithAlertViewKey object:nil];
    return self;
}

-(void)layoutSubviews{
	//[super layoutSubviews];
   
	BOOL isOverrid=NO;
    if ([[UIDevice currentDevice].systemVersion floatValue]>=5.0f)
    {
		isOverrid=YES;
	}
    [self changeAlertUI];

}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:CTDismissWithAlertViewKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

-(void)changeAlertUI
{
	int i=0;
	UIColor *textColor = CTALERTVIEW_TEXTCOLOR;
	for (UIView *v in [self subviews])
    {
        if ([v class] == [UIImageView class])
        {
            UIImageView* imageView = (UIImageView *)v;
            
            CGRect rect = imageView.frame;
            rect.origin.x -= (320-imageView.frame.size.width)/2;
            rect.origin.y = -20;
            rect.size.height += 30;
            int x = 2*rect.origin.x;
            if (x<0) 
            {
                x = -x;
            }
            
            rect.size.width += x; 
            
            if (rect.size.width > 320) {
                rect.size.width = 320;
            }            
            imageView.frame = rect;
            UIImage *bg_image=[UIImage imageNamed:CTALERTVIEW_BACKGROUNDIMAGE];
            bg_image=[bg_image stretchableImageWithLeftCapWidth:bg_image.size.width/2 topCapHeight:bg_image.size.height/2];
            [imageView setImage:bg_image];            
        }
        
        if ([v isKindOfClass:[UIButton class]]) {
            UIImage *btn_bg=[UIImage imageNamed:CTALERTVIEW_GRAYBUTTONIMAGE];
            UIImage *btn_bg_action=[UIImage imageNamed:CTALERTVIEW_ACTIONBUTTONIMAGE];
            UIColor *btn_title_color=[UIColor colorWithRed:118.0f/255.0f green:118.0f/255.0f blue:118.0f/255.0f alpha:1];
            if (i==0) {
                btn_title_color=[UIColor whiteColor];
                btn_bg=[UIImage imageNamed:CTALERTVIEW_NORMALBUTTONIMAGE];
                btn_bg_action=[UIImage imageNamed:CTALERTVIEW_ACTIONBUTTONIMAGE];
            }
            btn_bg=[btn_bg stretchableImageWithLeftCapWidth:btn_bg.size.width/2 topCapHeight:0];
            btn_bg_action=[btn_bg_action stretchableImageWithLeftCapWidth:btn_bg_action.size.width/2 topCapHeight:0];
            
            UIButton* btn = (UIButton *)v;
            
            [btn setBackgroundImage:btn_bg forState:UIControlStateNormal];
            [btn setBackgroundImage:btn_bg_action forState:UIControlStateHighlighted];
            
            [btn setTitleColor:btn_title_color forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
            btn.titleLabel.shadowColor = [UIColor clearColor];
            [btn.titleLabel setShadowOffset:CGSizeMake(0, 0)];            
            i++;
        }
        else if([v isKindOfClass:NSClassFromString(@"UIThreePartButton")])
        {
            UIImage *btn_bg=[UIImage imageNamed:CTALERTVIEW_GRAYBUTTONIMAGE];
            UIImage *btn_bg_action=[UIImage imageNamed:CTALERTVIEW_ACTIONBUTTONIMAGE];
            UIColor *btn_title_color=[UIColor colorWithRed:118.0f/255.0f green:118.0f/255.0f blue:118.0f/255.0f alpha:1];
            if (i==0) {
                btn_title_color=[UIColor whiteColor];
                btn_bg=[UIImage imageNamed:CTALERTVIEW_NORMALBUTTONIMAGE];
                btn_bg_action=[UIImage imageNamed:CTALERTVIEW_ACTIONBUTTONIMAGE];
            }
            btn_bg=[btn_bg stretchableImageWithLeftCapWidth:btn_bg.size.width/2 topCapHeight:btn_bg.size.height/2];
            btn_bg_action=[btn_bg_action stretchableImageWithLeftCapWidth:btn_bg_action.size.width/2 topCapHeight:btn_bg.size.height/2];



            
            
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
            
            UILabel *lbl=(UILabel *)v;
            [lbl setTextColor:textColor];
            [lbl setShadowOffset:CGSizeMake(0, 0)];
            [lbl setShadowColor:[UIColor clearColor]];
            //[self bringSubviewToFront:lbl];
        }
    }
}

-(void)clickbutton:(id)sender
{
	UIButton *btn=(UIButton *)sender;
    _alertviewIndex=0;
	if ([self.delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)])
    {
		[self.delegate alertView:self clickedButtonAtIndex:btn.tag];
	}
	[self dismissWithClickedButtonIndex:btn.tag animated:YES];
}


-(void)clickAlert:(NSNotification *)non
{
	 _alertviewIndex=0;
	if ([self.delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)])
    {
		[self.delegate alertView:self clickedButtonAtIndex:0];
	}
	[self dismissWithClickedButtonIndex:0 animated:YES];
}


@end
