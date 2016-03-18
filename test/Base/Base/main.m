//
//  main.m
//  Base
//
//  Created by MaYing on 15/7/17.
//  Copyright (c) 2015年 xmg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#include <stdarg.h>
void test(char * format,char * fff,...)
{
    va_list args;
    va_start (args, fff);
    char* a= va_arg(args, char*);
    char* b = va_arg(args, char*);
    char* c = va_arg(args, char*);
    
    printf("%s %s %s %s %s\n ",format,fff,a,b,c);
  
    va_end(args);
}

void WriteFormatted (char* format,char * fff, ...)
{
    va_list args;
    va_start (args, fff);
   
    test(format,fff,args);

}

int main(int argc, char * argv[]) {

    //WriteFormatted("a","b","1","2","3","4","5","6");
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
