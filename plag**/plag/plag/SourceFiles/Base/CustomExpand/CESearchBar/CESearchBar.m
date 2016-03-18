//
//  CESearchBar.m
//  ShoppingInLZ
//
//  Created by MaYing on 14-5-13.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import "CESearchBar.h"
#import "CTDevice.h"
#import "CETextField.h"
@implementation CESearchBar
@synthesize _cancelButton;
@synthesize _delegate;
@synthesize _textField;

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _isEditing = FALSE;
        float borderHeight = 1;
        UIView * border = [[[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - borderHeight, frame.size.width, borderHeight)] autorelease];
        [self addSubview:border];
        border.backgroundColor = RGBA(219, 219, 219, 1);
        //
        float leftDis = 10;
        float rightDis = 16;
        float buttonOriginY = 0;
        if(IS_IOS7_OR_LATER)
        {
            buttonOriginY += 20;
        }
        UIFont * font = [UIFont systemFontOfSize:15];
        NSString * text = @"取消";
        float buttonWidth = rightDis + [text sizeWithFont:font].width + 11;
        float buttonHeight = 44;
        float buttonOriginX = frame.size.width - buttonWidth;
        self._cancelButton = [[[UIButton alloc] initWithFrame:CGRectMake(buttonOriginX, buttonOriginY, buttonWidth, buttonHeight)] autorelease];
        [self addSubview:self._cancelButton];
        [self._cancelButton setTitle:text forState:UIControlStateNormal];
        [self._cancelButton setTitleColor:RGBA(225, 83, 35, 1) forState:UIControlStateNormal];
        self._cancelButton.titleLabel.font = font;
        [self._cancelButton addTarget:self action:@selector(cancelButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        //
        
        float textFieldOriginX = leftDis;
        float textFieldWidth = buttonOriginX - leftDis;
        float textFieldHeight = 36;
        float textFeildOriginY = buttonOriginY + (buttonHeight - textFieldHeight) / 2 - 1;
        CETextField * textField = [[[CETextField alloc] initWithFrame:CGRectMake(textFieldOriginX, textFeildOriginY, textFieldWidth, textFieldHeight)] autorelease];
        textField.dx = 12;
        self._textField = textField;
        [self addSubview:self._textField];
        self._textField.placeholder = @"请输入关键字";
        self._textField.delegate = self;
        self._textField.keyboardType = UIKeyboardTypeDefault;
        self._textField.returnKeyType = UIReturnKeySearch;
        self._textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self._textField.clearButtonMode = UITextFieldViewModeAlways;
        self._textField.font = [UIFont systemFontOfSize:15];
        self._textField.backgroundColor = RGBA(248, 248, 248, 1);
        //self._textField.layer.cornerRadius=8.0f;
        self._textField.layer.masksToBounds=YES;
        self._textField.layer.borderColor=[RGBA(217, 217, 217, 1) CGColor];
        float borderWidth = 1;
        if(IS_IOS7_OR_LATER)
            borderWidth = 0.5;
        self._textField.layer.borderWidth= borderWidth;
       
        //
        _textFieldShadowView = [[UIView alloc] initWithFrame:self._textField.frame];
        [[_textFieldShadowView layer] setShadowOffset:CGSizeMake(1, 1)];
        [[_textFieldShadowView layer] setShadowRadius:5];
        [[_textFieldShadowView layer] setShadowOpacity:1];
        [[_textFieldShadowView layer] setShadowColor:RGBA(99, 91, 88, 1).CGColor];
        [self insertSubview:_textFieldShadowView belowSubview:self._textField];
        [_textFieldShadowView release];
        _textFieldShadowView.backgroundColor = [UIColor clearColor];
        
        self.backgroundColor = [UIColor whiteColor];
        //
    }
    return self;
}

-(void)dealloc
{
    self._cancelButton = 0;
    self._textField = 0;
    [self removeCoverButtonToSuperView];
    [super dealloc];
}

-(void)cancelButtonClicked
{
    [self afterStopEditing];
    if(self._delegate)
    {
        [self._delegate cancelSearch:self];
    }
}

-(void)beforeEditingAnimation
{
    CGRect textFieldFrame = self._textField.frame;
    float disX = 4;
    float disY = 4;
    textFieldFrame.origin.x -= disX / 2;
    textFieldFrame.origin.y -= disY / 2;
    textFieldFrame.size.width += disX;
    textFieldFrame.size.height += disY;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _coverButton.backgroundColor = RGBA(0, 0, 0, 0.4);
    self._textField.frame = textFieldFrame;
    //阴影
    _textFieldShadowView.backgroundColor = [UIColor whiteColor];
    [UIView commitAnimations];

}
-(void)afterEditingAnimation
{
    CGRect textFieldFrame = self._textField.frame;
    float disX = 4;
    float disY = 4;
    textFieldFrame.origin.x += disX / 2;
    textFieldFrame.origin.y += disY / 2;
    textFieldFrame.size.width -= disX;
    textFieldFrame.size.height -= disY;
    self._textField.frame = textFieldFrame;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removeCoverButtonToSuperView)];
    [UIView setAnimationDuration:0.3];
    _coverButton.backgroundColor = [UIColor clearColor];
    
    //阴影
    _textFieldShadowView.backgroundColor = [UIColor clearColor];
    [UIView commitAnimations];
}
-(void)addCoverButtonToSuperView
{
    UIView * supView = self.superview;
    if(!_coverButton && supView)
    {
        CGRect supFrame = supView.frame;
        CGRect selFrame = self.frame;
        float originX = selFrame.origin.x;
        float originY = selFrame.origin.y + selFrame.size.height;
        float width = selFrame.size.width;
        float height = supFrame.size.height - originY;
        _coverButton = [[UIButton alloc] initWithFrame:CGRectMake(originX, originY, width, height)];
        _coverButton.backgroundColor = [UIColor clearColor];
        [_coverButton addTarget:self action:@selector(coverButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    if(supView)
    {
        [_coverButton removeFromSuperview];
        [supView addSubview:_coverButton];
    }
    
}
-(void)removeCoverButtonToSuperView
{
    if(_coverButton)
    {
        [_coverButton removeFromSuperview];
        [_coverButton release];
        _coverButton = 0;
    }
}
-(void)beforeStartEditing
{
    if(!_isEditing)
    {
        _isEditing = TRUE;
        [self addCoverButtonToSuperView];
        [self beforeEditingAnimation];
    }
}
-(void)afterStopEditing
{
    if(_isEditing)
    {
        [self afterEditingAnimation];
        [self._textField resignFirstResponder];
        _isEditing = FALSE;
    }
}
-(void)coverButtonClicked
{
    [self afterStopEditing];
}

#pragma mark UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self afterStopEditing];
    if(self._delegate)
    {
        [self._delegate search:self key:textField.text];
    }
    return TRUE;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self beforeStartEditing];
    return TRUE;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL res = TRUE;
    return res;
}

@end
