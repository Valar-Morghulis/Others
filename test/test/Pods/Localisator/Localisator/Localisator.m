//
//  Localisator.m
//  CustomLocalisator
//
//  Created by Michael Azevedo on 05/03/2014.
//

#import "Localisator.h"

#define LanguageUserDefaultKey @"LanguageUserDefaultKey"
 NSString * LanguageChangedNotificationKey = @"LanguageChangedNotificationKey";

@interface Localisator()
{
    NSDictionary * _dic;
}
@property (nonatomic,retain) NSDictionary * _dic;

@end

@implementation Localisator
@synthesize _currentLanguage;
@synthesize _dic;
@synthesize _saveInUserDefaults;

-(void)dealloc
{
    self._currentLanguage = 0;
    self._dic = 0;
    [super dealloc];
}

+ (Localisator*)instance
{
    static Localisator *_instance = 0l;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _instance = [[Localisator alloc] init];
        _instance._saveInUserDefaults = TRUE;
    });
    return _instance;
}

- (id)init
{
    if (self = [super init])
    {
        self._currentLanguage = SystemLanguage;
        //
        _saveInUserDefaults = [[NSUserDefaults standardUserDefaults] objectForKey:LanguageUserDefaultKey] != 0;
        //
        NSString * languageSaved = [[NSUserDefaults standardUserDefaults] objectForKey:LanguageUserDefaultKey];
        if (languageSaved && ![languageSaved isEqualToString:SystemLanguage])
        {
            [self loadDictionaryForLanguage:languageSaved];
        }
    }
    return self;
}

-(void)set_saveInUserDefaults:(BOOL)saveInUserDefaults
{
    _saveInUserDefaults = saveInUserDefaults;
    if(_saveInUserDefaults && self._currentLanguage)
    {
        [[NSUserDefaults standardUserDefaults] setObject:self._currentLanguage forKey:LanguageUserDefaultKey];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:LanguageUserDefaultKey];
    }
}

-(BOOL)loadDictionaryForLanguage:(NSString *)newLanguage
{
    BOOL res = FALSE;
    NSURL * urlPath = [[NSBundle mainBundle] URLForResource:@"Localizable" withExtension:@"strings" subdirectory:nil localization:newLanguage];
    if ([[NSFileManager defaultManager] fileExistsAtPath:urlPath.path])
    {
        self._currentLanguage = newLanguage;
        self._dic = [NSDictionary dictionaryWithContentsOfFile:urlPath.path];
        res = TRUE;
    }
    return res;
}


-(NSString *)localizedStringForKey:(NSString*)key
{
    NSString * res = 0;
    if (!self._dic)
    {
        res = NSLocalizedString(key, key);
    }
    else
    {
        res = self._dic[key];
        if(!res)  res = key;
    }
    return res;
}

-(BOOL)setLanguage:(NSString *)newLanguage
{
    BOOL res = FALSE;
    if(newLanguage && ![newLanguage isEqualToString:self._currentLanguage])
    {
        //是否为系统语言
        if([newLanguage isEqualToString:SystemLanguage])
        {
            self._currentLanguage = newLanguage;
            self._dic = 0;//
            res = TRUE;
        }
        else res = [self loadDictionaryForLanguage:newLanguage];
    }
    if(res)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:LanguageChangedNotificationKey object:nil];
        if (self._saveInUserDefaults)
        {
            [[NSUserDefaults standardUserDefaults] setObject:self._currentLanguage forKey:LanguageUserDefaultKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    return res;
}


@end
