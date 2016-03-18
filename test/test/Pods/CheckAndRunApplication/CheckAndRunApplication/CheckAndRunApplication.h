//
//  CheckAndRunApplication.h
//  testApp
//
//  Created by MaYing on 13-8-21.
//  Copyright (c) 2013年 MaYing. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface CheckAndRunApplication : NSObject
{
    NSMutableArray * _currentApplicationArray;//
}
-(BOOL)isApplicationEixstByIdentifier:(NSString *)identifier;

-(BOOL)runApplicationByIdentifier:(NSString*)identifier;

-(BOOL)runApplicationByURLScheme:(NSString*)urlScheme;

+(id)instance;
@end
