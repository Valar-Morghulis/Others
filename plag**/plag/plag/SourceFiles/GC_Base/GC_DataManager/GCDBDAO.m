//
//  GCDBDAO.m
//  ShoppingInLZ
//
//  Created by MaYing on 14-7-2.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import "GCDBDAO.h"
#import "YAJL.h"

#define GCDataBaseFileName @"gcdb.sqlite"   //数据库名称
#define GCCacheTableName @"GC_PersonalAddressList"     //表名
static GCDBDAO * _instance = 0;

@implementation GCDBDAO
@synthesize _dbPath;

-(id)init
{
    if(self = [super init])
    {
        NSArray*paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString*documentsDirectory =[paths objectAtIndex:0];
        
        self._dbPath = [documentsDirectory stringByAppendingPathComponent:GCDataBaseFileName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if(![fileManager fileExistsAtPath:self._dbPath])
        {
            //复制
            NSString * oldPath = [[NSBundle mainBundle] pathForResource:GCDataBaseFileName ofType:0];
            if([fileManager fileExistsAtPath:oldPath])
            {
                [fileManager copyItemAtPath:oldPath toPath:self._dbPath error:0];
            }
        }
        
        if([fileManager fileExistsAtPath:self._dbPath])
        {
           //打开数据库
            sqlite3_open([self._dbPath UTF8String], &_db);
        }
    }
    return self;
}

-(void)dealloc
{
    if(_db)
        sqlite3_close(_db);
    self._dbPath = 0;
    [super dealloc];
}
-(void)cacheData:(NSString *)phone name:(NSString *)name company:(NSString *)company position:(NSString *)position
{
    if(phone && _db)
    {
        NSString * sql = 0;
        if([self hasData:phone])
        {
            sql = [NSString stringWithFormat:@"update %@ set name = '%@',company = '%@',position = '%@' where phone = '%@'",GCCacheTableName,name,company,position,phone];
        }
        else
        {
            sql = [NSString stringWithFormat:@"insert into %@ values('%@','%@','%@','%@')",GCCacheTableName,phone,name,company,position];
        }
        if(sql)
        {
            sqlite3_exec(_db, [sql UTF8String], 0, 0, 0);
        }
    }
}

-(NSDictionary *)hasData:(NSString *)phone
{
    NSDictionary * res = 0;
    if(phone && _db)
    {
        NSString * sql = [NSString stringWithFormat:@"select * from %@ where phone = '%@'",GCCacheTableName,phone];
        sqlite3_stmt *statement = 0;
        if (sqlite3_prepare_v2(_db,[sql UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            //遍历数据
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                const char * phone = (const char*)sqlite3_column_text(statement, 0);
                const char * name = (const char*)sqlite3_column_text(statement, 1);
                const char * company = (const char*)sqlite3_column_text(statement, 2);
                const char * position = (const char*)sqlite3_column_text(statement, 3);
                res = [NSMutableDictionary dictionary];
                if(phone)
                {
                    [res setValue:[NSString stringWithUTF8String:phone] forKey:@"phone"];
                }
                if(name)
                {
                    [res setValue:[NSString stringWithUTF8String:name] forKey:@"name"];
                }
                if(company)
                {
                    [res setValue:[NSString stringWithUTF8String:company] forKey:@"company"];
                }
                if(position)
                {
                    [res setValue:[NSString stringWithUTF8String:position] forKey:@"position"];
                }
                
                break;
            }
            sqlite3_finalize(statement);
        }//fi
    }
    return res;
}
-(NSArray *)getDatas
{
    NSMutableArray * res = [NSMutableArray array];
    NSString * sql = [NSString stringWithFormat:@"select * from %@",GCCacheTableName];
    sqlite3_stmt *statement = 0;
    if (sqlite3_prepare_v2(_db,[sql UTF8String], -1, &statement, NULL) == SQLITE_OK)
    {
        //遍历数据
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            const char * phone = (const char*)sqlite3_column_text(statement, 0);
            const char * name = (const char*)sqlite3_column_text(statement, 1);
            const char * company = (const char*)sqlite3_column_text(statement, 2);
            const char * position = (const char*)sqlite3_column_text(statement, 3);
            NSDictionary * dic = [NSMutableDictionary dictionary];
            if(phone)
            {
                [dic setValue:[NSString stringWithUTF8String:phone] forKey:@"phone"];
            }
            if(name)
            {
                [dic setValue:[NSString stringWithUTF8String:name] forKey:@"name"];
            }
            if(company)
            {
                [dic setValue:[NSString stringWithUTF8String:company] forKey:@"company"];
            }
            if(position)
            {
                [dic setValue:[NSString stringWithUTF8String:position] forKey:@"position"];
            }
            [res addObject:dic];
        }
         sqlite3_finalize(statement);
    }//fi
   
    return res;
}

+(GCDBDAO *)instance
{
    if(!_instance)
    {
        _instance = [[GCDBDAO alloc] init];
    }
    return _instance;
}


@end
