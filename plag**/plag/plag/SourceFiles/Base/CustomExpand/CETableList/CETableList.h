//
//  CETableList.h
//  ShoppingMall
//
//  Created by MaYing on 13-11-15.
//
//

#import <UIKit/UIKit.h>
#import "CTTableView.h"
#import "CTDataSource.h"
#import "CTTableViewCell.h"

#import "CustomExpandDefine.h"

@class CETableList;
@protocol CETableListDelegate
-(void)didSelectedCell:(CETableList *)list cell:(CTTableViewCell *)cell withData:(NSDictionary *)data;//选中cell
-(void)didScrollToSectionFirstCell:(CETableList *)list cell:(CTTableViewCell *) cell withData:(NSDictionary *)data;//滚动到section处才会触发

-(void)beforeReloadData:(CETableList *)list;
-(void)afterReloadData:(CETableList *)list isEmpty:(BOOL) isEmpty;//加载完数据之后

@end

@interface CETableList : UIView
<CTDataSourceDelegate,
UIScrollViewDelegate,
UITableViewDelegate>
{
    UITableView * _tableView;
    CTDataSource * _CTDataSource;
    id<CETableListDelegate> _delegate;
    
    NSIndexPath * _currentIndexPath;
    float _sectionHeaderHeight;
    float _cellHeight;
    //
    //
    int _currentPageIndex;
}
@property(nonatomic,retain) UITableView * _tableView;
@property(nonatomic,retain) CTDataSource * _CTDataSource;
@property(nonatomic,assign) id<CETableListDelegate> _delegate;

@property(nonatomic,retain) NSIndexPath * _currentIndexPath;
@property(nonatomic,readwrite) float _sectionHeaderHeight;
@property(nonatomic,readwrite) float _cellHeight;

@property(nonatomic,readonly) int _currentPageIndex;
@end
