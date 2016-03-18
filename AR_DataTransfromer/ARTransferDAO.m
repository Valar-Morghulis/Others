//
//  ARTransferDAO.m
//  AR_DataTransfromer
//
//  Created by MaYing on 14-2-26.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import "ARTransferDAO.h"
#import "YAJL.h"
@implementation ARTransferDAO
-(void)dealloc
{
    [self close];
    [super dealloc];
}
-(void)openDB:(NSString *)dbPath
{
    [self close];
    
    sqlite3_open([dbPath UTF8String], &_db);
    
}
-(void)close
{
    if(_db)
    {
        sqlite3_close(_db);
        _db = 0;
    }
}
-(NSMutableArray *)getARData
{
    NSMutableArray * res = [[[NSMutableArray alloc] init] autorelease];
    
    const char * sql = "select gid,type,image,name,geom from  IndoorMap_Building";
    sqlite3_stmt *statement = 0;
	if (sqlite3_prepare_v2(_db,sql, -1, &statement, NULL) == SQLITE_OK)
	{
		//遍历数据
		while (sqlite3_step(statement) == SQLITE_ROW)
		{
            ARData * data = [[ARData alloc] init];
            data._id = sqlite3_column_int(statement, 0);
            NSString * typeStr = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
            int typeInt = 0;
            if([typeStr isEqualToString:@"购物"])
            {
                typeInt = 2;
            }
            else if([typeStr isEqualToString:@"办公"])
            {
                typeInt = 0;
            }
            else if([typeStr isEqualToString:@"酒店"])
            {
                typeInt = 3;
            }
            else if([typeStr isEqualToString:@"餐饮"])
            {
                typeInt = 1;
            }
            data._type = typeInt;
            
            const char * image = (const char *)sqlite3_column_text(statement, 2);
            if(image)
            {
                data._trademarkUrl = [NSString stringWithUTF8String:image];
            }
            
            const char * name = (const char *)sqlite3_column_text(statement, 3);
             if(name)
             {
                 data._name = [NSString stringWithUTF8String:name];
             }
            const char * geom = (const char *)sqlite3_column_text(statement, 4);
            if(geom)
            {
                NSString * geomStr = [NSString stringWithUTF8String:geom];
                NSDictionary * geomDic = [geomStr yajl_JSON];
                if(geomDic)
                {
                    NSArray * coordinates = [geomDic objectForKey:@"coordinates"];
                    if(coordinates)
                    {
                        if([coordinates count] > 0)
                            data._lon = [[coordinates objectAtIndex:0] floatValue];
                        if([coordinates count] > 1)
                            data._lat = [[coordinates objectAtIndex:1] floatValue];
                        if([coordinates count] > 2)
                            data._alt = [[coordinates objectAtIndex:2] floatValue];
                    }
                }
            }
            
            [res addObject:data];
            [data release];
        }
		sqlite3_finalize(statement);
	}
    return res;
}


@end
