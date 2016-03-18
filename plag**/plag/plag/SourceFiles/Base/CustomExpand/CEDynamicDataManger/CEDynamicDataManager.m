//
//  CEDynamicDataManager.m
//  guangCity
//
//  Created by MaYing on 13-12-19.
//
//

#import "CEDynamicDataManager.h"

static CEDynamicDataManager * _instance = 0;

@implementation CEDynamicDataManager

@synthesize _dynamicDataFilePath;
@synthesize _delegate;
@synthesize _network;


-(id)init
{
    if(self = [super init])
    {
         _dynamicData = [[NSMutableDictionary alloc] init];
        self._network = [[[CTNetwork alloc] init] autorelease];
        self._network._delegate = self;
        [self changeDynamicFilePathWithFileName:CE_DYNAMIC_DATA_FIILE_NAME];
    }
    return self;
}

-(void)dealloc
{
    [_dynamicData release];
    self._dynamicDataFilePath = 0;
    self._network = 0;
    [super dealloc];
}
-(void)changeDynamicFilePathWithFileName:(NSString *)fileName
{
    NSArray*paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString*documentsDirectory =[paths objectAtIndex:0];
    
    self._dynamicDataFilePath =[documentsDirectory stringByAppendingPathComponent:fileName];
    _checkCache = FALSE;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary * dic = 0;
    if(![fileManager fileExistsAtPath:self._dynamicDataFilePath])
    {
        //复制
        NSString * oldPath = [[NSBundle mainBundle] pathForResource:fileName ofType:0];
        if([fileManager fileExistsAtPath:oldPath])
        {
             [fileManager copyItemAtPath:oldPath toPath:self._dynamicDataFilePath error:0];
        }
    }
    
    if([fileManager fileExistsAtPath:self._dynamicDataFilePath])
    {
        NSData * data = [NSData dataWithContentsOfFile:self._dynamicDataFilePath];
        NSString * content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        dic = [content yajl_JSON];
        [content release];
        
        [_dynamicData release];
        _dynamicData = [[NSMutableDictionary alloc] initWithDictionary:dic];
    }
}
-(NSDictionary *)getDynamicDataForKey:(NSString *)key
{
    return [_dynamicData objectForKey:key];
}


-(void)cacheDynamicData:(NSDictionary *)data forKey:(NSString *)key
{
    if(data)
    {
        [_dynamicData setObject:data forKey:key];
    }
    else
    {
        [_dynamicData removeObjectForKey:key];
    }
    NSString *content= [_dynamicData yajl_JSONString];
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    [contentData writeToFile:self._dynamicDataFilePath atomically:YES];
}
//
-(void)clear
{
    [_dynamicData removeAllObjects];
    NSString *content= [_dynamicData yajl_JSONString];
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    [contentData writeToFile:self._dynamicDataFilePath atomically:YES];
}

+(CEDynamicDataManager *)instance
{
    if(!_instance)
    {
        _instance = [[CEDynamicDataManager alloc] init];
    }
    return _instance;
}


#pragma mark CTNetworkDelegate 网络
-(void)beforeNetworkStart:(CTNetwork *)network
{
    
}
-(BOOL)isResultVaild:(CTNetwork *)network data:(NSDictionary *)data
{
    return TRUE;
}
-(void)networkStoped:(CTNetwork *)network success:(int)success
{
    
}
-(void)afterNetworkStoped:(CTNetwork *)network
{
    
}
@end
