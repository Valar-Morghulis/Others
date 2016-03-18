//
//  NSDictionary+MutableDeepCopy.m
//  guangCity
//
//  Created by MaYing on 13-12-31.
//
//

#import "NSDictionary+MutableDeepCopy.h"


@implementation NSDictionary(MutableDeepCopy)

- (NSMutableDictionary *) mutableDeepCopyOfDictionary
{
    NSMutableDictionary *newDict = [NSMutableDictionary dictionaryWithCapacity:[self count]];
    NSArray *keys = [self allKeys];
    for (id key in keys) {
        id oneValue = [self valueForKey:key];
        id oneCopy =nil;
        if ([oneValue respondsToSelector:@selector(mutableDeepCopyOfDictionary)]) {
            oneCopy = [[oneValue mutableDeepCopyOfDictionary] retain];
        }
        else if ([oneValue respondsToSelector:@selector(mutableDeepCopyOfArray)]) {
            oneCopy = [[oneValue mutableDeepCopyOfArray] retain];
        }
        else if ([oneValue conformsToProtocol:@protocol(NSMutableCopying)]) {
            oneCopy = [oneValue mutableCopy];
        }
        
        if (oneCopy ==nil) {
            oneCopy = [oneValue copy];
        }
        [newDict setObject:oneCopy forKey:key];
        [oneCopy release];
    }
    return newDict;
}

@end


@implementation NSArray(MutableDeepCopy)

- (NSMutableArray *)mutableDeepCopyOfArray {
    NSMutableArray *newArray = [NSMutableArray arrayWithCapacity:[self count]];
    for (int i = 0; i < [self count]; i++) {
        id oneValue = [self objectAtIndex:i];
        id oneCopy =nil;
        if ([oneValue respondsToSelector:@selector(mutableDeepCopyOfArray)]) {
            oneCopy = [[oneValue mutableDeepCopyOfArray] retain];
        }
        else if ([oneValue respondsToSelector:@selector(mutableDeepCopyOfDictionary)]) {
            oneCopy = [[oneValue mutableDeepCopyOfDictionary] retain];
        }
        else if ([oneValue conformsToProtocol:@protocol(NSMutableCopying)]) {
            oneCopy = [oneValue mutableCopy];
        }
        if (oneCopy ==nil) {
            oneCopy = [oneValue copy];
        }
        [newArray addObject:oneCopy];
        [oneCopy release];
    }
    return newArray;
}

@end
