//
//  GCLoginManager.h
//  Cofcofuture
//
//  Created by MaYing on 14-4-10.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCLoginManager : NSObject
{
    NSString * _configFilePath;
    NSMutableDictionary * _loginData;
    NSDictionary * _userInfo;//用户数据
}
@property(nonatomic,retain) NSString * _configFilePath;

@property(nonatomic,readwrite) BOOL _isLogin;//是否登陆
@property(nonatomic,retain) NSString * _userName;//用户名
@property(nonatomic,readwrite) BOOL _isRecord;//是否记住用户名
@property(nonatomic,retain) NSDictionary * _userInfo;//用户数据
-(void)update;//

+(GCLoginManager *)instance;
@end
