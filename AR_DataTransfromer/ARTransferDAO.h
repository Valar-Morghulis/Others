//
//  ARTransferDAO.h
//  AR_DataTransfromer
//
//  Created by MaYing on 14-2-26.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "sqlite3.h"
#import "ARData.h"

@interface ARTransferDAO : NSObject
{
    sqlite3 * _db;
}
-(void)openDB:(NSString *)dbPath;

-(NSMutableArray *)getARData;


@end
