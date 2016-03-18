//
//  CEMoveDataSource.h
//  guangCity
//
//  Created by MaYing on 13-12-19.
//
//

#import "CTDataSource.h"
#import "CEMoveTableView.h"
#import "CEMoveTableViewCell.h"
#import "CustomExpandDefine.h"

@interface CEMoveDataSource : CTDataSource<CEMoveTableViewDataSource>
{
    NSMutableArray * _splitRowArray;
}
-(float)heightForRowAtIndexPath:(NSIndexPath *)indexPath;
-(BOOL)canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
@end
