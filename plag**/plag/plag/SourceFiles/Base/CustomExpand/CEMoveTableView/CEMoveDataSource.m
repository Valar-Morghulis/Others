//
//  CEMoveDataSource.m
//  guangCity
//
//  Created by MaYing on 13-12-19.
//
//

#import "CEMoveDataSource.h"

@implementation CEMoveDataSource
-(id)init
{
    if(self = [super init])
    {
        _splitRowArray = [[NSMutableArray alloc] init];
    }
    return self;
}
-(void)dealloc
{
    [_splitRowArray release];
    [super dealloc];
}

-(void)clearData:(BOOL)animate
{
    [_splitRowArray removeAllObjects];
    [super clearData:animate];
}
-(BOOL)canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL res = TRUE;
    NSDictionary * dic = [self._dataArray objectAtIndex:indexPath.row];
    res = ![[dic objectForKey:@"isSplit"] boolValue];
    return res;
}
-(float)heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float res = DEFAULT_CEMAIN_SETTINGLIST_CELL_HEIGHT;
    NSDictionary * dic = [self._dataArray objectAtIndex:indexPath.row];
    BOOL isSplit = [[dic objectForKey:@"isSplit"] boolValue];
    if(isSplit)
    {
        res = DEFAULT_CEMAIN_SETTINGLIST_SPLIT_CELL_HEIGHT;
    }
    return res;
}

-(void)doAddData:(NSDictionary *)data
{
    if(data)
    {
        NSArray * dataArray = [data objectForKey:@"array"];
        if(dataArray)
        {
            NSMutableArray * datas = [NSMutableArray arrayWithArray:self._dataArray];
            [datas addObjectsFromArray:dataArray];
            self._dataArray = datas;
        }
    }
}


#pragma mark CEMoveTableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self._dataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"CEMoveTableViewCell";
    CEMoveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[[CEMoveTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    BOOL isMovingCell = [tableView indexPathIsMovingIndexPath:indexPath];
    NSDictionary * data = [self._dataArray objectAtIndex:indexPath.row];
    [cell set_data:data];
    BOOL isSplit = [[data objectForKey:@"isSplit"] boolValue];
    if(isSplit)
    {
        [_splitRowArray addObject:[NSNumber numberWithInt:indexPath.row]];
    }
    //
    if (isMovingCell)
	{
		[cell prepareForMove];
	}
    else
    {
        [cell prepareForStill];
    }
    return cell;
}


- (void)moveTableView:(CEMoveTableView *)tableView moveRowFromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSMutableArray * datas = (NSMutableArray *)self._dataArray;
    NSMutableDictionary *movieDic = [[datas objectAtIndex:[fromIndexPath row]]retain];
    //NSMutableDictionary * newData = (NSMutableDictionary *)data;
    for(NSNumber * number in _splitRowArray)
    {
        BOOL isChanged = FALSE;
        BOOL isUsed = TRUE;
        int splitRow = [number intValue];
        if(fromIndexPath.row < toIndexPath.row)//下移
        {
            isUsed = TRUE;
            if(fromIndexPath.row <= splitRow && toIndexPath.row >= splitRow)
            {
                isChanged = TRUE;
                isUsed = FALSE;
            }
        }
        else //上移
        {
            isUsed = FALSE;
            if(fromIndexPath.row >= splitRow && toIndexPath.row <= splitRow)
            {
                isChanged = TRUE;
                isUsed = TRUE;
            }
        }
        
        if(isChanged)
        {
            [_splitRowArray removeObject:number];
            splitRow = isUsed ? splitRow + 1 : splitRow - 1;
            number = [NSNumber numberWithInt:splitRow];
            [_splitRowArray addObject:number];
            
            [movieDic setObject:[NSNumber numberWithBool:isUsed] forKey:@"isUsed"];
        }
        
        break;
    }
    
	[datas removeObjectAtIndex:[fromIndexPath row]];
	[datas  insertObject:movieDic atIndex:[toIndexPath row]];
    [movieDic release];
}



@end
