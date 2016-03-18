//
//  CTDataSource.m
//  XFDesigners
//
//  Created by yaoyongping on 12-12-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CTDataSource.h"

@implementation CTDataSource
@synthesize _dataArray;
@synthesize _allowEdit;
@synthesize _delegate;

-(id)init
{
	if (self=[super init])
    {
		self._allowEdit = FALSE;
	}
	return self;
}

-(void)dealloc{
    self._dataArray = 0;
	[super dealloc];
}

-(void)doAddData:(NSDictionary *)data
{
    if(data)
    {
        NSArray * dataArray = [data objectForKey:@"data"];
        if(dataArray)
        {
            NSMutableArray * datas = [NSMutableArray arrayWithArray:self._dataArray];
            [datas addObjectsFromArray:dataArray];
            self._dataArray = datas;
        }
    }
}
-(void)addData:(NSDictionary *)newData animate:(BOOL)animate
{
    [self doAddData:newData];
    if(self._delegate)
    {
        [self._delegate afterAddedData:self animate:animate];
    }
}
-(void)clearData:(BOOL) animate
{
    self._dataArray = 0;
    if(self._delegate)
    {
        [self._delegate afterClearedData:self animate:animate];
    }
}
-(BOOL)isEmpty
{
    return ([self._dataArray count] == 0);
}


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
    static NSString * identifier = @"CTTableViewCell";
    CTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[[CTTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    NSDictionary * data = [self._dataArray objectAtIndex:indexPath.row];
    cell._data = data;
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath 
{ 
    return UITableViewCellEditingStyleDelete; 
} 
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath 
{
    return self._allowEdit;
} 

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
{ 
    NSLog(@"点击了编辑");
	int index=indexPath.row;
	NSMutableArray *d=(NSMutableArray *)self._dataArray;
	[d removeObjectAtIndex:index];
	[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}


@end

