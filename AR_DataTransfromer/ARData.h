//
//  ARData.h
//  AR_DataTransfromer
//
//  Created by MaYing on 14-2-26.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARData : NSObject
{
    int _id;
    int _type;
    NSString * _trademarkUrl;
    NSString * _name;
    float _lat;
    float _lon;
    float _alt;
}
@property(nonatomic,readwrite) int _id;
@property(nonatomic,readwrite) int _type;
@property(nonatomic,retain) NSString * _trademarkUrl;
@property(nonatomic,retain)  NSString * _name;
@property(nonatomic,readwrite) float _lat;
@property(nonatomic,readwrite) float _lon;
@property(nonatomic,readwrite) float _alt;
@end
