//
//  CESearchBar.h
//  ShoppingInLZ
//
//  Created by MaYing on 14-5-13.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CESearchBar;
@protocol CESearchBarDelegate
-(void)cancelSearch:(CESearchBar *)searchBar;
-(void)search:(CESearchBar *)searchBar key:(NSString *)key;
@end

@interface CESearchBar : UIView<UITextFieldDelegate>
{
    UITextField * _textField;
    UIView * _textFieldShadowView;
    UIButton * _cancelButton;
    id<CESearchBarDelegate> _delegate;
    UIButton * _coverButton;
    BOOL _isEditing;
}
@property(nonatomic,retain) UITextField * _textField;
@property(nonatomic,retain) UIButton * _cancelButton;
@property(nonatomic,assign) id<CESearchBarDelegate> _delegate;

@end
