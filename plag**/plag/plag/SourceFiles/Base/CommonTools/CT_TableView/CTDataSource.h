//
//  CTDataSource.h
//  XFDesigners
//
//  Created by yaoyongping on 12-12-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTTableViewCell.h"

@class CTDataSource;

@protocol CTDataSourceDelegate <NSObject>

-(void)afterAddedData:(CTDataSource *)dataSource animate:(BOOL)animate;
-(void)afterClearedData:(CTDataSource *)dataSource animate:(BOOL)animate;
@end


@interface CTDataSource : NSObject<UITableViewDataSource>
{
	NSArray *_dataArray;
	BOOL _allowEdit;
    id<CTDataSourceDelegate> _delegate;
}
@property(nonatomic,retain)NSArray *_dataArray;
@property(nonatomic,readwrite)BOOL _allowEdit;
@property(nonatomic,assign) id<CTDataSourceDelegate> _delegate;

-(void)addData:(NSDictionary *)newData animate:(BOOL)animate;
-(void)clearData:(BOOL) animate;//清空数据
-(BOOL)isEmpty;//是否为空
-(void)doAddData:(NSDictionary *)data;
@end

