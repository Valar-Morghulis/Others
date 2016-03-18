//
//  CTDownload.h
//  CTDownload
//
//  Created by Hao Tan on 11-11-19.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APP_GlobeDefine.h"
#import "CommonToolsDefine.h"
@class CTDownload;

@protocol CTDownloadDelegate<NSObject>

@optional
//下载开始(responseHeaders为服务器返回的下载文件的信息)
- (void)downloadBegin:(CTDownload *)aDownload didReceiveResponseHeaders:(NSURLResponse *)responseHeaders;
//下载失败
- (void)downloadFaild:(CTDownload *)aDownload didFailWithError:(NSError *)error;
//下载结束
- (void)downloadFinished:(CTDownload *)aDownload;
//更新下载的进度
- (void)downloadProgressChange:(CTDownload *)aDownload progress:(double)newProgress;

@end
@interface CTDownload : NSObject 
{    
	__unsafe_unretained id<CTDownloadDelegate> delegate;      
    BOOL       overwrite;                        
	NSURL      *url;
	NSString   *fileName;
    NSString   *filePath;
    unsigned long long fileSize;
    
    NSFileHandle        *fileHandle;    
    NSString   *destinationPath;
 @private
    
    NSString   *temporaryPath;
    NSURLConnection     *connection;
    unsigned long long  offset;
}

@property(nonatomic,retain)NSString   *destinationPath;
@property (nonatomic, retain)   NSFileHandle    *fileHandle;

@property (nonatomic, assign) id<CTDownloadDelegate> delegate;
/*
 当文件名相同时是否覆盖,overwriter为NO的时候，当文件已经存在，则下载结束
 */
@property (nonatomic, assign) BOOL overwrite;
/*
 下载的地址,当下载地址为nil，下载失败
 */
@property (nonatomic, retain) NSURL *url;
/*
 下载文件的名字名，默认为下载原文件名
 */
@property (nonatomic, retain) NSString *fileName;
/*
 文件保存的path(不包括文件名),默认路径为DocumentDirectory
 */
@property (nonatomic, retain) NSString *filePath;
/*
 下载的大小,只有当下载任务成功启动之后才能获取
 */
@property (nonatomic, readonly) unsigned long long fileSize;

- (void)start;              //开始下载
- (void)stop;               //停止下载
- (void)stopAndClear;       //停止清理(己下载完成的或缓存)

-(NSString *)getFilePath;
@end
