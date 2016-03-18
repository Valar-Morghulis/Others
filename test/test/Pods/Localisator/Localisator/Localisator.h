//
//  Localisator.h
//  CustomLocalisator
//
//  Created by Michael Azevedo on 05/03/2014.
//

#import <Foundation/Foundation.h>

#define LOCALIZATION(key) [[Localisator instance] localizedStringForKey:(key)]

FOUNDATION_EXTERN  NSString * LanguageChangedNotificationKey;//通知
static const NSString * SystemLanguage = @"SystemLanguage";//系统语言标识


@interface Localisator : NSObject
{
    BOOL _saveInUserDefaults;
    NSString * _currentLanguage;
}
//
@property (nonatomic, readwrite) BOOL _saveInUserDefaults;
@property(nonatomic,retain) NSString * _currentLanguage;//en、zh-CN
+ (Localisator*)instance;
-(NSString *)localizedStringForKey:(NSString*)key;
-(BOOL)setLanguage:(NSString*)newLanguage;//en、zh-CN


@end
