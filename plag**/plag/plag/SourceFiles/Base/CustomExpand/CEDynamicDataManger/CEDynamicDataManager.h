//
//  CEDynamicDataManager.h
//  guangCity
//
//  Created by MaYing on 13-12-19.
//
//

#import <Foundation/Foundation.h>
#import "YAJL.h"
#import "CTNetwork.h"
#import "APP_GlobeDefine.h"


@protocol CEDynamicDataManagerDelegate
@end
@interface CEDynamicDataManager : NSObject<CTNetworkDelegate>
{
    id<CEDynamicDataManagerDelegate> _delegate;
    CTNetwork * _network;
    NSString * _dynamicDataFilePath;
    BOOL _checkCache;
    NSMutableDictionary * _dynamicData;
}
@property(nonatomic,assign) id<CEDynamicDataManagerDelegate> _delegate;
@property(nonatomic,retain) CTNetwork * _network;
@property(nonatomic,retain) NSString * _dynamicDataFilePath;

//get
-(NSDictionary *)getDynamicDataForKey:(NSString *)key;

//cache
-(void)cacheDynamicData:(NSDictionary *)data forKey:(NSString *)key;
//
-(void)clear;



+(CEDynamicDataManager *)instance;
-(void)changeDynamicFilePathWithFileName:(NSString *)fileName;
@end
