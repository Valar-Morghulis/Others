//
//  CEGuideViewController.m
//  GX_Shopping_Map
//
//  Created by MaYing on 13-9-16.
//  Copyright (c) 2013年 MaYing. All rights reserved.
//

#import "CEGuideViewController.h"


@implementation CEGuideViewController
@synthesize _delegate;
@synthesize _isGuideUsedBefore;
@synthesize _isGuideUsedKey;
@synthesize _configDic;

-(id)init
{
    if(self = [super init])
    {
        _isGuideUsedBefore = TRUE;
    }
    return self;
    
}
-(void)initlizeWithKey:(NSString *)key
{
    self._isGuideUsedKey = key;
    
    NSFileManager*fileManager =[NSFileManager defaultManager];
    NSError*error;
    NSArray*paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString*documentsDirectory =[paths objectAtIndex:0];
    NSString * oldPath = [[NSBundle mainBundle] pathForResource:GUIDE_CONFIG_FILE_NAME ofType:GUIDE_CONFIG_FILE_TYPE];
    
    NSString * configFileName = [NSString stringWithFormat:@"%@.%@",GUIDE_CONFIG_FILE_NAME,GUIDE_CONFIG_FILE_TYPE];
    
    NSString* newPath =[documentsDirectory stringByAppendingPathComponent:configFileName];
    
    if([fileManager fileExistsAtPath:newPath]== NO)
    {
        [fileManager copyItemAtPath:oldPath toPath:newPath error:&error];
    }
    
    _guideConfigFilePath = [newPath retain];
    
    
    NSString * fileContentString = [NSString stringWithContentsOfFile:_guideConfigFilePath encoding:NSUTF8StringEncoding error:0];
    self._configDic = [NSMutableDictionary dictionaryWithDictionary:[fileContentString yajl_JSON]];
    _isGuideUsedBefore = [[self._configDic objectForKey:self._isGuideUsedKey] boolValue];
}

-(void)dealloc
{
    self._isGuideUsedKey = 0;
    self._configDic = 0;
    
    [_guideConfigFilePath release];
    _guideConfigFilePath = 0;
    self._delegate = 0;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = [[UIScreen mainScreen] bounds];
    [self makeGuideView];
}
-(void)makeGuideView
{
    float guideScrollViewOriginX = 0;
    float guideScrollViewOriginY = 0;
    float guideScrollViewWidth = self.view.frame.size.width;
    float guideScrollViewHeight = self.view.frame.size.height;
    
    UIScrollView * guideScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(guideScrollViewOriginX, guideScrollViewOriginY, guideScrollViewWidth, guideScrollViewHeight)];
    [guideScrollView setPagingEnabled:YES];
    [guideScrollView setShowsHorizontalScrollIndicator:NO];
    guideScrollView.backgroundColor = [UIColor clearColor];
    NSArray * guidePageArray = [self._configDic objectForKey:@"guideConfigs"];
    guideScrollView.contentSize = CGSizeMake(guideScrollViewWidth * [guidePageArray count], guideScrollViewHeight);
    [self.view addSubview:guideScrollView];
    [guideScrollView release];
    guideScrollView.delegate = self;
    
    CGRect lastRect = CGRectZero;
    for(int i=0;i<[guidePageArray count];i++)
    {
        NSString * imageName = [guidePageArray objectAtIndex:i];
        UIImage *image=[UIImage imageNamed:imageName];
        image=[image stretchableImageWithLeftCapWidth:0 topCapHeight:image.size.height-2];
        lastRect = CGRectMake(i * guideScrollViewWidth, 0, guideScrollViewWidth, guideScrollViewHeight);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:lastRect];
        imageView.image = image;
        
        //        CGRect rect=imageView.frame;
        //        float h=image.size.height*320.0/image.size.width;
        //        if (rect.size.height>h) {
        //            rect.origin.y=(rect.size.height-h)/2.0;
        //            rect.size.height=h;
        //        }
        //        [imageView setFrame:rect];
        
        
        [guideScrollView addSubview:imageView];
        [imageView release];
    }
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:lastRect];
    button.backgroundColor = [UIColor clearColor];
    [guideScrollView addSubview:button];
    [button addTarget:self action:@selector(finishGuide) forControlEvents:UIControlEventTouchUpInside];
    [button release];
}
-(void)saveToFile
{
#if 1
    _isGuideUsedBefore = TRUE;
    //尝试改写
    [self._configDic setObject:[NSNumber numberWithBool:_isGuideUsedBefore] forKey:self._isGuideUsedKey];
    NSString * configStr  = [self._configDic yajl_JSONString];
    [configStr writeToFile:_guideConfigFilePath atomically:TRUE encoding:NSUTF8StringEncoding error:0];
    
#endif
}
-(void)finishGuide
{
    [self saveToFile];
    if (self._delegate)
    {
        [self._delegate guideFinished:self];
    }
}

@end
