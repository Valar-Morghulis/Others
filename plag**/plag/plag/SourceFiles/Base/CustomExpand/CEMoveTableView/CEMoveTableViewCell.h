//
//  CEMoveTableViewCell.h
//  guangCity
//
//  Created by MaYing on 13-12-19.
//
//

#import "CTTableViewCell.h"
#import "CEMoveTableView.h"

#import "CustomExpandDefine.h"
@interface CEMoveTableViewCell : CTTableViewCell
{
    CTDownImageView * _imageView;
    UILabel * _titleLabel;
    UIView * _coverView;
}
@property(nonatomic,retain) CTDownImageView * _imageView;
@property(nonatomic,retain) UILabel * _titleLabel;
@end
