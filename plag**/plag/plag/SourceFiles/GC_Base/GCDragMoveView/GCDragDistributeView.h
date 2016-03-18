//
//  GCDragDistributeView.h
//  plag
//
//  Created by MaYing on 15/6/1.
//  Copyright (c) 2015年 xiaofu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GCDragMoveControl.h"
#import "GCDragMoveHeaderAndFooter.h"


@class GCDragDistributeView;
@protocol GCDragDistributeViewDelegate
-(void)beforeDistribute:(GCDragDistributeView *)view isUp:(BOOL)isUp;
-(void)afterDistribute:(GCDragDistributeView *)view isUp:(BOOL)isUp;

-(UIView *)anotherView;//

@end

@interface GCDragDistributeView : UIView<GCDragMoveControlDelegate>
{
    GCDragMoveHeader * _header;
    GCDragMoveFooter * _footer;
    UIView * _currentContainer;
    GCDragMoveControl * _control;

    id<GCDragDistributeViewDelegate> _delegate;
    //
    CGRect _headerFrame;//累计记录frame
    CGRect _footerFrame;//累计记录frame
    
    //
    CGRect _originalHeaderFrame;
    CGRect _originalFooterFrame;
    CGRect _originalContainerFrame;
    //
}
@property(nonatomic,retain) GCDragMoveHeader * _header;
@property(nonatomic,retain) GCDragMoveFooter * _footer;
@property(nonatomic,retain) UIView * _currentContainer;
@property(nonatomic,retain) GCDragMoveControl * _control;


//
@property(nonatomic,assign)  id<GCDragDistributeViewDelegate> _delegate;

-(void)load;

@end
