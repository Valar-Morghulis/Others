//
//  CTGridViewItem.h
//  PaiHaoBao
//
//  Created by MaYing on 14-10-16.
//  Copyright (c) 2014年 MaYing. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    CTGridItemNormalMode = 0,
    CTGridItemEditingMode = 1,
}CTGridItemMode;


@class CTGridViewItem;

@protocol CTGridViewItemDelegate
- (void) gridItemDidClicked:(CTGridViewItem *) gridItem;
- (void) gridItemDidEnterEditingMode:(CTGridViewItem *) gridItem;
- (void) gridItemDidDeleted:(CTGridViewItem *) gridItem atIndex:(NSInteger)index;
- (void) gridItemDidMoved:(CTGridViewItem *) gridItem withLocation:(CGPoint)point moveGestureRecognizer:(UILongPressGestureRecognizer*)recognizer;
- (void) gridItemDidEndMoved:(CTGridViewItem *) gridItem withLocation:(CGPoint)point moveGestureRecognizer:(UILongPressGestureRecognizer*) recognizer;
@end

@interface CTGridViewItem : UIView
{
    id<CTGridViewItemDelegate> _delegate;
    BOOL _isEditing;//
    BOOL _isRemovable;//
    CGPoint _longPressPoint;//
    int _index;//
    
    UIButton * _deleteButton;//
    UIButton * _coverButton;//
    NSDictionary * _data;//
    UILongPressGestureRecognizer * _longPressGesture;
    BOOL _isPicked;//
    BOOL _isEnableEditingDone;
}
@property(nonatomic,readonly) BOOL _isEnableEditingDone;//动画是否完成
@property(nonatomic,retain) NSDictionary * _data;
@property(nonatomic,assign) id<CTGridViewItemDelegate> _delegate;
@property(nonatomic,readonly) BOOL _isEditing;//
@property(nonatomic,readwrite) BOOL _isRemovable;//
@property(nonatomic,readwrite) CGPoint _longPressPoint;//
@property(nonatomic,readwrite) int _index;//

@property(nonatomic,retain) UIButton * _deleteButton;//
@property(nonatomic,retain) UIButton * _coverButton;//

-(void)enableEditing:(BOOL)animate;//
-(void)disableEditing:(BOOL)animate;//

-(void)selectSelf:(BOOL)animate;
-(void)unselectSelf:(BOOL)animate;

-(void)parseData;//
-(id)initWithFrame:(CGRect)frame removable:(BOOL)removable index:(int)index;

@end
