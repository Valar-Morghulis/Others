//
//  NSDictionary+MutableDeepCopy.h
//  guangCity
//
//  Created by MaYing on 13-12-31.
//
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>

@interface NSDictionary(MutableDeepCopy)
// NSDictionary深拷贝方法
- (NSMutableDictionary *)mutableDeepCopyOfDictionary;
@end

@interface NSArray(MutableDeepCopy)
// NSArray深拷贝方法
- (NSMutableArray *)mutableDeepCopyOfArray;
@end