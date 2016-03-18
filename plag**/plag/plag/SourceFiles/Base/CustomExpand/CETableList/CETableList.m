//
//  CETableList.m
//  ShoppingMall
//
//  Created by MaYing on 13-11-15.
//
//

#import "CETableList.h"

@implementation CETableList
@synthesize _tableView;
@synthesize _CTDataSource;
@synthesize _delegate;
@synthesize _sectionHeaderHeight;
@synthesize _currentIndexPath;
@synthesize _cellHeight;
@synthesize _currentPageIndex;

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _currentPageIndex = 0;
        self._cellHeight = DEFAULT_CE_TABLELIST_CELL_HEIGHT;
        self._sectionHeaderHeight = DEFAULT_CE_TABLELIST_SECTION_HEADER_HEIGHT;
        
        
        self.backgroundColor = [UIColor clearColor];
        //添加CTTableView
        float tableViewOriginX = 0;
        float tableViewOriginY = 0;
        float tableViewHeight = frame.size.height;
        float tableViewWidth = frame.size.width;
        
        CTTableView * tableView = [[CTTableView alloc] initWithFrame:CGRectMake(tableViewOriginX, tableViewOriginY, tableViewWidth, tableViewHeight)];
        self._tableView = tableView;
        [tableView release];
        [self addSubview:self._tableView];//
        self._tableView.delegate = self;
        self._tableView.backgroundColor = [UIColor clearColor];
        //dataSource
        CTDataSource * aGoodsDataSource = [[CTDataSource alloc] init];
        aGoodsDataSource._delegate = self;
        self._CTDataSource = aGoodsDataSource;
        [aGoodsDataSource release];
        self._tableView.dataSource = self._CTDataSource;
    }
    return self;
}


-(void)dealloc
{
    self._tableView = 0;
    self._CTDataSource = 0;
    self._currentIndexPath = 0;
    
    [super dealloc];
}

#pragma mark TableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* headerView = [[[UIView alloc] init] autorelease];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self._sectionHeaderHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self._cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self._delegate)
    {
        CTTableViewCell *cell = (CTTableViewCell*)[self._tableView cellForRowAtIndexPath:indexPath];
        
        [self._delegate didSelectedCell:self cell:cell withData:cell._data];
        
    }
}

#pragma mark UIScrollviewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int topGap = 0;
    float contentOffsetY =scrollView.contentOffset.y;
    float startJudgePos = self._sectionHeaderHeight * 2;//不能低于_sectionHeaderHeight * 2,开始滚动时的判断位置
    float normalJudgePos = 0;//当contentOffsetY超过startJudgePos后的判断位置
    if (contentOffsetY < startJudgePos)
    {
        topGap = self._sectionHeaderHeight;
    }
    else
    {
        topGap = normalJudgePos;
    }
    
    topGap += contentOffsetY;
    
    NSIndexPath *indexPath = [self._tableView indexPathForRowAtPoint:CGPointMake(scrollView.contentOffset.x, topGap)];//滚动位置处的index
    if(indexPath)
    {
        BOOL needCallDelegate = TRUE;
        if(self._currentIndexPath && self._currentIndexPath.section == indexPath.section)
        {
            needCallDelegate = FALSE;
        }
        if(needCallDelegate && self._delegate)//滚动到新的商家
        {
            CTTableViewCell *cell = (CTTableViewCell*)[self._tableView cellForRowAtIndexPath:indexPath];
            [self._delegate didScrollToSectionFirstCell:self cell:cell withData:cell._data];
        }
    }
    
    self._currentIndexPath = indexPath;//更新当前索引
    
}


#pragma mark CTDataSourceDelegate

-(void)afterAddedData:(CTDataSource *)dataSource animate:(BOOL)animate
{
    if(animate && self._delegate)
    {
        [self._delegate beforeReloadData:self];
    }
    _currentPageIndex++;
    [self._tableView reloadData];
    if(animate && self._delegate)
    {
        [self._delegate afterReloadData:self isEmpty:[self._CTDataSource isEmpty]];
    }

}
-(void)afterClearedData:(CTDataSource *)dataSource animate:(BOOL)animate
{
    if(animate && self._delegate)
    {
        [self._delegate beforeReloadData:self];
    }
    [self._tableView reloadData];
    self._currentIndexPath = 0;
    _currentPageIndex = 0;
    [self._tableView scrollRectToVisible:CGRectMake(0, 0, self._tableView.frame.size.height,self._tableView.frame.size.height)animated:TRUE];
    if(animate && self._delegate)
    {
        [self._delegate afterReloadData:self isEmpty:[self._CTDataSource isEmpty]];
    }

}

@end
