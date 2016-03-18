//
//  main.m
//  test
//
//  Created by MaYing on 15/8/13.
//  Copyright (c) 2015年 xmg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "Test.h"
int main(int argc, char * argv[])
{

    @autoreleasepool {
        
        Test * t = [Test new];
       
        
        
        
        Test2 * t2 = [Test2 new];
        t2.t = t;
        
        [t setValue:@"name" forKey:@"name"];
        [t setValue:@"str1" forKey:@"str1"];
        [t setValue:@"str2" forKey:@"_str2"];
        t.str2 = @"111";
        NSLog(@"%@  %@  %@",[t valueForKey:@"name"],t.str1,t.str2);
        
        
        Test2 * t3 = [Test2 new];
        t3.t = t2.t;
        
        
        NSString * str = @"123";
        t.str1 = str;
        t.str2 = str;
        NSLog(@"%p -- %p -- %p",str,t.str1,t.str2);
        
        
        //
        str = [NSString stringWithFormat:@"456"];
        t.str1 = str;
        t.str2 = str;
        NSLog(@"%p -- %p -- %p",str,t.str1,t.str2);
        
        
        //
        str = [[NSString alloc] initWithCString:"789" encoding:NSUTF8StringEncoding];
        t.str1 = str;
        t.str2 = str;
        NSLog(@"%p -- %p -- %p",str,t.str1,t.str2);
        //
        str = [[NSMutableString alloc] init];
        [((NSMutableString *)str)appendString:@"111"];
        t.str1 = str;
        t.str2 = str;
        NSLog(@"%p -- %p -- %p",str,t.str1,t.str2);
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
