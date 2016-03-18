//
//  CEMoveTableView.h
//  test
//
//  Created by MaYing on 13-12-19.
//  Copyright (c) 2013年 MaYing. All rights reserved.
//

#import <UIKit/UIKit.h>


//
@interface CESnapShotImageView : UIImageView
- (void)moveByOffset:(CGPoint)offset;
@end

@interface UIGestureRecognizer (CEUtilities)
- (void)cancelTouch;
@end

@interface UITableViewCell (CEMove)
-(void)prepareForMove;
-(void)prepareForStill;
@end
@interface UITableView (CEMove)
- (BOOL)indexPathIsMovingIndexPath:(NSIndexPath *)indexPath;
@end
//
@class CEMoveTableView;

@protocol CEMoveTableViewDelegate <UITableViewDelegate>
- (BOOL)moveTableView:(CEMoveTableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;//should
- (void)moveTableView:(CEMoveTableView *)tableView beforeMoveRowAtIndexPath:(NSIndexPath *)indexPath;//before
- (void)moveTableView:(CEMoveTableView *)tableView afterMoveRowAtIndexPath:(NSIndexPath *)indexPath;//after

- (NSIndexPath *)moveTableView:(CEMoveTableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath;//
@end

@protocol CEMoveTableViewDataSource <UITableViewDataSource>
- (void)moveTableView:(CEMoveTableView *)tableView moveRowFromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath;
@end



@interface CEMoveTableView : UITableView <UIGestureRecognizerDelegate>
{
    NSIndexPath *_movingIndexPath;
    
    CGPoint _touchOffset;
    CESnapShotImageView *_snapShotImageView;
    UILongPressGestureRecognizer *_movingGestureRecognizer;
    
    NSTimer *_autoscrollTimer;
    NSInteger _autoscrollDistance;
    NSInteger _autoscrollThreshold;
}
@property (nonatomic, assign) id <CEMoveTableViewDataSource> dataSource;
@property (nonatomic, assign) id <CEMoveTableViewDelegate> delegate;
@property (nonatomic, retain) NSIndexPath *movingIndexPath;

//
@property (nonatomic, readwrite) CGPoint touchOffset;
@property (nonatomic, retain) CESnapShotImageView *snapShotImageView;
@property (nonatomic, retain) UILongPressGestureRecognizer *movingGestureRecognizer;

@property (nonatomic, retain) NSTimer *autoscrollTimer;
@property (nonatomic, readwrite) NSInteger autoscrollDistance;
@property (nonatomic, readwrite) NSInteger autoscrollThreshold;

@end




