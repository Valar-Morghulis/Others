//
//  GCDBDAO.h
//  ShoppingInLZ
//
//  Created by MaYing on 14-7-2.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
@interface GCDBDAO : NSObject
{
    sqlite3 * _db;
    NSString * _dbPath;
}
@property(nonatomic,retain) NSString * _dbPath;

-(void)cacheData:(NSString *)phone name:(NSString *)name company:(NSString *)company position:(NSString *)position;
-(NSDictionary *)hasData:(NSString *)phone;
-(NSArray *)getDatas;

+(GCDBDAO *)instance;
@end
