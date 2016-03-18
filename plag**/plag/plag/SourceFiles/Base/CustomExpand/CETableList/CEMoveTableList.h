//
//  CEMoveTableList.h
//  guangCity
//
//  Created by MaYing on 13-12-19.
//
//

#import "CETableList.h"
#import "CEMoveTableView.h"
#import "CEMoveDataSource.h"

@protocol CEMoveTableListDelegate <CETableListDelegate>

-(void)beforeMoveCell :(CETableList *)list cell:(CTTableViewCell *)cell data:(NSDictionary *)data;
-(void)afterMoveCell :(CETableList *)list cell:(CTTableViewCell *)cell data:(NSDictionary *)data;
@end

@interface CEMoveTableList : CETableList<CEMoveTableViewDelegate>
{
    UIButton * _maskButton;
    BOOL _isHidden;
}
@property(nonatomic,assign) id<CEMoveTableListDelegate> _delegate;

-(void)show;
-(void)hide;

-(void)autoShowOrHide;
@end
