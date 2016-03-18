//
// CECollectionView.h
//


#import <UIKit/UIKit.h>


@class CECollectionViewCell;

@protocol CECollectionViewDelegate, CECollectionViewDataSource;

@interface CECollectionView : UIScrollView
{
    float _marginX;//x间距
    float _marginY;//y间距
}
@property(nonatomic,readwrite) float _marginX;//x间距
@property(nonatomic,readwrite) float  _marginY;//y间距
#pragma mark - Public Properties

@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UIView *footerView;
@property (nonatomic, retain) UIView *emptyView;
@property (nonatomic, retain) UIView *loadingView;

@property (nonatomic, assign, readonly) CGFloat colWidth;
@property (nonatomic, assign, readonly) NSInteger numCols;
@property (nonatomic, assign) NSInteger numColsLandscape;
@property (nonatomic, assign) NSInteger numColsPortrait;
@property (nonatomic, assign) id <CECollectionViewDelegate> collectionViewDelegate;
@property (nonatomic, assign) id <CECollectionViewDataSource> collectionViewDataSource;

#pragma mark - Public Methods

/**
 Reloads the collection view
 This is similar to UITableView reloadData)
 */
- (void)reloadData;

/**
 Dequeues a reusable view that was previously initialized
 This is similar to UITableView dequeueReusableCellWithIdentifier
 */
- (UIView *)dequeueReusableView;
- (CECollectionViewCell *)dequeueReusableView:(NSString *)reuseIdentifier;//复用
@end

#pragma mark - Delegate

@protocol CECollectionViewDelegate <NSObject>

@optional
- (void)collectionView:(CECollectionView *)collectionView didSelectView:(CECollectionViewCell *)view atIndex:(NSInteger)index;

@end

#pragma mark - DataSource

@protocol CECollectionViewDataSource <NSObject>

@required
- (NSInteger)numberOfViewsInCollectionView:(CECollectionView *)collectionView;
- (CECollectionViewCell *)collectionView:(CECollectionView *)collectionView viewAtIndex:(NSInteger)index;
- (CGFloat)heightForViewAtIndex:(CECollectionView *)collectionView index:(NSInteger)index;

@end
