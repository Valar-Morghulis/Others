//
//  GCDragDistributeView.m
//  plag
//
//  Created by MaYing on 15/6/1.
//  Copyright (c) 2015年 xiaofu. All rights reserved.
//

#import "GCDragDistributeView.h"

@implementation GCDragDistributeView
@synthesize _currentContainer;
@synthesize _footer;
@synthesize _header;
@synthesize _control;
@synthesize _delegate;


-(void)dealloc
{
    self._control = 0;
    self._header = 0;
    self._footer = 0;
    self._currentContainer = 0;
    [super dealloc];
}
-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        float headerOriginX = 0;
        float headerWidth = frame.size.width;
        float headerOriginY = 0;
        float headerHeight = 25;
        _originalHeaderFrame = CGRectMake(headerOriginX, headerOriginY, headerWidth, headerHeight);
        self._header = [[[GCDragMoveHeader alloc] initWithFrame:_originalHeaderFrame] autorelease];
        [self addSubview:self._header];
        //
        float footerOriginX = 0;
        float footerHeight = headerHeight;
        float footerWidth = frame.size.width;
        float footerOriginY = frame.size.height - footerHeight;
        _originalFooterFrame = CGRectMake(footerOriginX, footerOriginY, footerWidth, footerHeight);
        
        self._footer = [[[GCDragMoveFooter alloc] initWithFrame:_originalFooterFrame] autorelease];
        [self addSubview:self._footer];

        //
        self._control = [[GCDragMoveControl alloc] init];
        self._control._delegate = self;
        //
    
        float contentOriginX = 0;
        float contentOriginY = headerOriginY + headerHeight;
        float contentWidth = frame.size.width;
        float contentHeight = footerOriginY - contentOriginY;
        _originalContainerFrame = CGRectMake(contentOriginX, contentOriginY, contentWidth, contentHeight);
        [self makeContentContainer];//
    
        
        [self initToDefault];//
        
    }
    return self;
}
-(void)makeContentContainer
{
    if(!self._currentContainer)
    {
        self._currentContainer = [[[UIView alloc] initWithFrame:_originalContainerFrame] autorelease];
        [self insertSubview:self._currentContainer aboveSubview:self._footer];//
        self._currentContainer.backgroundColor = [UIColor whiteColor];
        self._currentContainer.layer.shadowColor = [UIColor blackColor].CGColor;
        self._currentContainer.layer.shadowRadius = 5;
        self._currentContainer.layer.shadowOpacity = 0.9;
        self._currentContainer.layer.shadowOffset = CGSizeMake(0, 0);
    }
    
}
-(void)initToDefault
{
    self._header.frame = _originalHeaderFrame;//
    [self._header recoverState];
    
    //
    self._footer.frame = _originalFooterFrame;
    [self._footer recoverState];
    
    //
    self._currentContainer.frame = _originalContainerFrame;
    //
    self._control._targetView = self._currentContainer;
    _headerFrame = self._header.frame;
    _footerFrame = self._footer.frame;

}

-(void)load
{
    [self initToDefault];//
    if(self._delegate)
    {
        UIView *view = [self._delegate anotherView];
        [self._currentContainer addSubview:view];
    }
}

#pragma mark GCDragMoveControlDelegate
-(void)dragMoveBegin:(GCDragMoveControl *)control//开始
{
    
}
-(void)dragMoving:(GCDragMoveControl *)control deltaOffset:(CGPoint)deltaOffset
{
    //
    //计算header与footer的frame
    _headerFrame.size.height += deltaOffset.y;
    self._header.frame = _headerFrame;
    
    _footerFrame.size.height -= deltaOffset.y;
    _footerFrame.origin.y += deltaOffset.y;
    self._footer.frame = _footerFrame;
    CGPoint offset = control._offset;
    
    if(offset.y < 0)//向上移动
    {
        if(_headerFrame.size.height <= 0)//变化
        {
            [self._footer changeState];
        }
        else
        {
            //还原
            [self._footer recoverState];
        }
    }
    else //向下移动
    {
        if(_footerFrame.size.height <= 0)//变化
        {
            [self._header changeState];
        }
        else
        {
            //还原
            [self._header recoverState];
        }
    }
}
-(void)dragMoveStoped:(GCDragMoveControl *)control//停止
{
    CGPoint offset = control._offset;
    if(offset.y > -20 && offset.y < 20)
    {
        //恢复
        [UIView animateWithDuration:0.2 animations:^(void){
            [self initToDefault];
        } completion:^(BOOL finished){
        }];
        
    }
    else
    {
        UIView * anotherView = 0;
        if(self._delegate)
        {
            anotherView = [self._delegate anotherView];
        }
        //
        
        UIView * priviousContainer = self._currentContainer;
        self._currentContainer = 0;
        CGPoint offset = control._offset;
        BOOL isUp = offset.y < 0;
        //
        if(self._delegate)
        {
            [self._delegate beforeDistribute:self isUp:isUp];
        }
        
        //恢复
        [self makeContentContainer];//
        self._currentContainer.frame = priviousContainer.frame;
        if(anotherView)
        {
            [self._currentContainer addSubview:anotherView];
        }
        [UIView animateWithDuration:0.2 animations:^(void){
            [self initToDefault];//
        } completion:^(BOOL finished){
        }];
        //移除之前的
        CGRect pContainerFrame = priviousContainer.frame;
        if(isUp)
        {
            pContainerFrame.origin.y -= pContainerFrame.size.height;
        }
        else
        {
            pContainerFrame.origin.y += pContainerFrame.size.height;
        }
        [UIView animateWithDuration:0.5 animations:^(void){
            priviousContainer.frame = pContainerFrame;
        } completion:^(BOOL finished){
            if(self._delegate)
            {
                [self._delegate afterDistribute:self isUp:isUp];
                [priviousContainer removeFromSuperview];
            }
        }];
        
    }
}
@end
