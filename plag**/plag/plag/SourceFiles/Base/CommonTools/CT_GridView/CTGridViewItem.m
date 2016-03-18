//
//  CTGridViewItem.m
//  PaiHaoBao
//
//  Created by MaYing on 14-10-16.
//  Copyright (c) 2014年 MaYing. All rights reserved.
//

#import "CTGridViewItem.h"

@implementation CTGridViewItem

@synthesize _delegate;
@synthesize _deleteButton;
@synthesize _index;
@synthesize _isEditing;
@synthesize _isRemovable;
@synthesize _longPressPoint;
@synthesize _coverButton;
@synthesize _data;
@synthesize _isEnableEditingDone;
-(void)dealloc
{
    [_longPressGesture release];
    self._coverButton = 0;
    self._deleteButton = 0;
    self._data = 0;
    [super dealloc];
}
-(id)initWithFrame:(CGRect)frame removable:(BOOL)removable index:(int)index
{
    if(self = [self initWithFrame:frame])
    {
        self._isRemovable = removable;
        self._index = index;
        _isPicked = FALSE;
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        _isEditing = FALSE;
        _isRemovable = FALSE;
        _isEnableEditingDone = FALSE;
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:self.bounds];
        [button addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundColor:[UIColor clearColor]];
        [self addSubview:button];
        self._coverButton = button;
        
        //
        self._deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        float width = 25;
        float height = 25;
        float originX = -5;
        float originY = -5;
        [self._deleteButton setFrame:CGRectMake(originX,originY, width, height)];
        [self._deleteButton addTarget:self action:@selector(removeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self._deleteButton setHidden:TRUE];
        self._deleteButton.backgroundColor = [UIColor clearColor];
        [self._deleteButton setImage:[UIImage imageNamed:@"class_delete.png"] forState:UIControlStateNormal];//
        
    }
    return self;
}
-(void)set_isRemovable:(BOOL)isRemovable
{
    _isRemovable = isRemovable;
    if(_isRemovable)
    {
        if(!_longPressGesture)
        {
             _longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressedLong:)];
        }
        [self removeGestureRecognizer:_longPressGesture];
        [self addGestureRecognizer:_longPressGesture];
        [self addSubview:self._deleteButton];
    }
    else
    {
        if(_longPressGesture)
        {
            [self removeGestureRecognizer:_longPressGesture];
        }
        [self._deleteButton removeFromSuperview];
    }
}
-(void)set_data:(NSDictionary *)data
{
    if(_data != data)
    {
        if(_data) [_data release];
        _data = data;
        if(_data)
        {
            [_data retain];
            [self parseData];
        }
    }
}
-(void)parseData
{
    if(self._data)
    {
        UIImage * selectdImage = [UIImage imageNamed:[self._data objectForKey:@"selectedImage"]];
        [self._coverButton setImage:selectdImage forState:UIControlStateNormal];
    }
}
-(void)clickItem:(UIButton *)button
{
    if(self._delegate)
    {
        [self._delegate gridItemDidClicked:self];
    }
}
- (void) pressedLong:(UILongPressGestureRecognizer *) gestureRecognizer
{
    switch (gestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
            [self disableEditing:FALSE];
            //放大这个item
            _isPicked = TRUE;
            _longPressPoint = [gestureRecognizer locationInView:self];
            if(self._delegate)
            {
                [self._delegate gridItemDidEnterEditingMode:self];
            }
            [self selectSelf:TRUE];
            break;
        case UIGestureRecognizerStateEnded:
            _longPressPoint = [gestureRecognizer locationInView:self];
            if(self._delegate)
            {
                [self._delegate gridItemDidEndMoved:self withLocation:_longPressPoint moveGestureRecognizer:gestureRecognizer];
            }
            //变回原来大小
            [self unselectSelf:TRUE];
            [self enableEditing:TRUE];
            break;
        case UIGestureRecognizerStateFailed:
            break;
        case UIGestureRecognizerStateChanged:
            //移动
            if(self._delegate)
            {
                [self._delegate gridItemDidMoved:self withLocation:_longPressPoint moveGestureRecognizer:gestureRecognizer];
            }
            break;
        default:
            break;
    }
}
-(void)selectSelf:(BOOL)animate
{
    _isPicked = TRUE;
    [self.layer removeAllAnimations];//
    [self._deleteButton setHidden:FALSE];
    [self._coverButton setUserInteractionEnabled:FALSE];
    
    if(animate)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        self.layer.transform = CATransform3DMakeScale(1.08, 1.08, 1);
        [UIView commitAnimations];
    }
    else
    {
        self.layer.transform = CATransform3DMakeScale(1.08, 1.08, 1);
    }
}
-(void)unselectSelf:(BOOL)animate
{
    _isPicked = FALSE;
    if(animate)
    {
        [self.layer removeAllAnimations];//
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        self.layer.transform = CATransform3DIdentity;
        [UIView commitAnimations];
    }
    else
    {
        self.layer.transform = CATransform3DIdentity;
    }
}

- (void) removeButtonClicked:(UIButton *) sender
{
    if(self._delegate)
    {
        [self._delegate gridItemDidDeleted:self atIndex:self._index];
    }
}

-(void)enableEditing:(BOOL)animate
{
    if(_isPicked)
        return;
    _isEnableEditingDone = FALSE;
    _isEditing = TRUE;
    [self._deleteButton setHidden:FALSE];
    [self._coverButton setUserInteractionEnabled:FALSE];
    
    if(animate)
    {
        [UIView beginAnimations:@"enableEditing" context:nil];
        [UIView setAnimationDuration:0.5];
        self.layer.transform = CATransform3DMakeScale(0.9, 0.9, 1);
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(startShaking)];
        [UIView commitAnimations];
    }
    else
    {
        self.layer.transform = CATransform3DMakeScale(0.9, 0.9, 1);
        [self startShaking];
    }
}
-(void)disableEditing:(BOOL)animate
{
    _isEditing = FALSE;
    [self._deleteButton setHidden:TRUE];
    [self._coverButton setUserInteractionEnabled:TRUE];

    if(animate)
    {
        [self.layer removeAnimationForKey:@"shakeAnimation"];
        [UIView beginAnimations:@"disableEditing" context:nil];
        [UIView setAnimationDuration:0.5];
        self.layer.transform = CATransform3DIdentity;
        [UIView setAnimationDelegate:self];
        [UIView commitAnimations];

    }
    else
    {
        [self.layer removeAnimationForKey:@"shakeAnimation"];
        self.layer.transform = CATransform3DIdentity;
    }
}

-(void)startShaking
{
    _isEnableEditingDone = TRUE;
    CGFloat rotation = 0.03;
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform"];
    shake.duration = 0.13;
    shake.autoreverses = TRUE;
    shake.repeatCount  = MAXFLOAT;
    shake.removedOnCompletion = FALSE;
    shake.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform,-rotation, 0.0 ,0.0 ,1.0)];
    shake.toValue   = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, rotation, 0.0 ,0.0 ,1.0)];
    [self.layer addAnimation:shake forKey:@"shakeAnimation"];
}

@end
