//
//  CEMainTableList.m
//  guangCity
//
//  Created by MaYing on 13-12-19.
//
//

#import "CEMoveTableList.h"
#import "CustomExpandDefine.h"
@implementation CEMoveTableList

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
         _isHidden = TRUE;
        
        CGRect tableFrame = [self._tableView frame];
        [self._tableView removeFromSuperview];
        self._tableView = 0;
        //
        
        CEMoveTableView * tableView = [[CEMoveTableView alloc] initWithFrame:tableFrame];
        self._tableView = tableView;
        [tableView release];
        [self addSubview:self._tableView];
        //
        self._tableView.delegate = self;
        self._tableView.backgroundColor = [UIColor clearColor];
        //self._tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self._sectionHeaderHeight = DEFAULT_CE_MOVETABLELIST_SECTION_HEIGHT;
        self._cellHeight = DEFAULT_CEMAIN_SETTINGLIST_CELL_HEIGHT;

        //dataSource
        CEMoveDataSource * aGoodsDataSource = [[CEMoveDataSource alloc] init];
        aGoodsDataSource._delegate = self;
        self._CTDataSource = aGoodsDataSource;
        [aGoodsDataSource release];
        self._tableView.dataSource = self._CTDataSource;

    }
    return self;
}
-(void)dealloc
{
    if(_maskButton)
    {
        [_maskButton release];
    }
    [super dealloc];
}


//
-(void)addMaskButton
{
    if(self.superview)
    {
        if(!_maskButton)
        {
            CGRect maskButtonFrame = {CGPointZero,self.superview.frame.size};
            _maskButton = [[UIButton alloc] initWithFrame:maskButtonFrame];
            _maskButton.backgroundColor = [UIColor clearColor];
            [_maskButton addTarget:self action:@selector(maskButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [self.superview addSubview:_maskButton];
    }
}
-(void)maskButtonClicked
{
    [self hide];
}
-(void)removeMaskButton
{
    if(_maskButton)
    {
        [_maskButton removeFromSuperview];
    }
}
-(void)show
{
    if(_isHidden && self.superview)
    {
        [self addMaskButton];//
        
        CGRect superFrame = self.superview.frame;
        superFrame.origin.x -= self.frame.size.width;
        superFrame.size.width += self.frame.size.width;
        [self doAnimationToFrame:superFrame];
        _isHidden = FALSE;
    }
}
-(void)hide
{
    if(!_isHidden)
    {
        [self removeMaskButton];
        if(self.superview)
        {
            CGRect superFrame = self.superview.frame;
            superFrame.origin.x = 0;
            superFrame.size.width =320;
            [self doAnimationToFrame:superFrame];
            _isHidden = TRUE;
        }
    }
}
-(void)autoShowOrHide
{
    if(_isHidden)
    {
        [self show];
        [self setHidden:NO];
    }
    else
    {
        [self hide];
    }
}
-(void)doAnimationToFrame:(CGRect)toFrame
{
    [UIView beginAnimations:@"CEMoveTableList" context:nil];
    [UIView setAnimationDuration:DEFAULT_CE_MOVETABLELIST_ANIMATION_DURATION_TIME];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:NO];
    
    self.superview.frame = toFrame;
    [UIView commitAnimations];
}



#pragma mark CEMoveTableViewDelegate
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [(CEMoveDataSource *)self._CTDataSource heightForRowAtIndexPath:indexPath];
}
- (BOOL)moveTableView:(CEMoveTableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [(CEMoveDataSource *)self._CTDataSource canMoveRowAtIndexPath:indexPath];
}
- (void)moveTableView:(CEMoveTableView *)tableView beforeMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    CTTableViewCell *cell = (CTTableViewCell*)[self._tableView cellForRowAtIndexPath:indexPath];
    if(self._delegate)
    {
        [self._delegate beforeMoveCell:self cell:cell data:cell._data];
    }
}
- (void)moveTableView:(CEMoveTableView *)tableView afterMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    CTTableViewCell *cell = (CTTableViewCell*)[self._tableView cellForRowAtIndexPath:indexPath];
    if(self._delegate)
    {
        [self._delegate afterMoveCell:self cell:cell data:cell._data];
    }
}

- (NSIndexPath *)moveTableView:(CEMoveTableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    if ([sourceIndexPath section] != [proposedDestinationIndexPath section])
    {
		proposedDestinationIndexPath = sourceIndexPath;
	}
	return proposedDestinationIndexPath;

}


@end
