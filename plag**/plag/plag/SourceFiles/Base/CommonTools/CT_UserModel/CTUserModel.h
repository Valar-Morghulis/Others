//
//  CTUserModel.h
//  GIIBank1.0
//
//  Created by li xiangji on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "APP_GlobeDefine.h"

#define USERMODEL [CTUserModel instance]

@interface CTUserModel : NSObject
{
    NSString* _sessionID;
    NSString* _userName;
    
}
@property(nonatomic, retain) NSString* _sessionID;
@property(nonatomic, retain) NSString* _userName;

+(CTUserModel *)instance;
@end




