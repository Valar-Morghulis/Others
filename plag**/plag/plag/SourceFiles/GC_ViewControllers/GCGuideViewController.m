//
//  GCGuideViewController.m
//  GuangCity
//
//  Created by MaYing on 14-10-23.
//  Copyright (c) 2014年 xiaofu. All rights reserved.
//

#import "GCGuideViewController.h"
#import "CEPageControl.h"

@implementation GCGuideViewController


-(void)makeGuideView
{
    //
    CGRect frame = self.view.frame;
    
    UIImageView * imgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:imgView];
    imgView.image = [UIImage imageNamed:@"guide_bg.jpg"];
    
    float guideScrollViewOriginX = 0;
    float guideScrollViewOriginY = 0;
    float guideScrollViewWidth = frame.size.width;
    float guideScrollViewHeight = frame.size.height;
    UIScrollView * guideScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(guideScrollViewOriginX, guideScrollViewOriginY, guideScrollViewWidth, guideScrollViewHeight)];
    [guideScrollView setPagingEnabled:YES];
    [guideScrollView setShowsHorizontalScrollIndicator:NO];
    guideScrollView.backgroundColor = [UIColor clearColor];
    NSArray * guidePageArray = [self._configDic objectForKey:@"guideConfigs"];
    guideScrollView.contentSize = CGSizeMake(guideScrollViewWidth * [guidePageArray count], guideScrollViewHeight);
    [self.view addSubview:guideScrollView];
    [guideScrollView release];
    guideScrollView.delegate = self;
    
    //
    float headOriginX = 0;
    float headWidth = frame.size.width;
    float headOriginY = 75;
    float headHeight = 280;
    _headImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(headOriginX, headOriginY,headWidth , headHeight)] autorelease];
    [self.view addSubview:_headImageView];
    _headImageOriginFrame = _headImageView.frame;
    //
    //
    float buttonContainerHeight = 17;
    float buttonContainerOriginY = frame.size.height - buttonContainerHeight - 95;
    float buttonContainerOriginX = 95;
    float buttonContainerWidth = frame.size.width - buttonContainerOriginX * 2;
    _buttonContainer = [[[UIView alloc] initWithFrame:CGRectMake(buttonContainerOriginX, buttonContainerOriginY, buttonContainerWidth, buttonContainerHeight)] autorelease];
    [self.view addSubview:_buttonContainer];
    _buttonContainerOriginFrame = _buttonContainer.frame;
    
    float buttonOriginX = 0;
    float buttonHeight = buttonContainerHeight;
    float buttonOriginY = 0;
    float buttonDisX = 40;
    float buttonWidth = (buttonContainerWidth - buttonDisX) / 2;
    
    UIButton * registButton = [[[UIButton alloc] initWithFrame:CGRectMake(buttonOriginX, buttonOriginY, buttonWidth, buttonHeight)] autorelease];
    [_buttonContainer addSubview:registButton];
    [registButton addTarget:self action:@selector(registButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [registButton setTitle:@"注册" forState:UIControlStateNormal];
    [registButton setTitleColor:RGBA(230, 120, 97, 1) forState:UIControlStateNormal];
    registButton.titleLabel.font = [UIFont systemFontOfSize:16];
    
    buttonOriginX += buttonWidth + buttonDisX;
    UIButton * loginButton = [[[UIButton alloc] initWithFrame:CGRectMake(buttonOriginX, buttonOriginY, buttonWidth, buttonHeight)] autorelease];
    [_buttonContainer addSubview:loginButton];
    [loginButton addTarget:self action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:RGBA(230, 120, 97, 1) forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:16];
    

    float wordHeight = 59;
    float wordOriginY = guideScrollViewHeight - wordHeight - 132;
    
    for(int i = 0;i < [guidePageArray count];i++)
    {
        NSDictionary * dic = [guidePageArray objectAtIndex:i];
        NSString * imageName = [dic objectForKey:@"guide_word"];
        UIImage *image=[UIImage imageNamed:imageName];
        image=[image stretchableImageWithLeftCapWidth:0 topCapHeight:image.size.height-2];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * guideScrollViewWidth, wordOriginY, guideScrollViewWidth, wordHeight)];
        imageView.image = image;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [guideScrollView addSubview:imageView];
    //imageView.backgroundColor = [UIColor redColor];
        [imageView release];
    }

    
    float pageControlOriginX = 0;
    float pageControlHeight = 9;//
    float pageControlDisY = 50;
    float pageControlOriginY = frame.size.height - pageControlHeight - pageControlDisY;
    float pageControlWidth = frame.size.width - pageControlOriginX;
    
    _pageControl = [[[CEPageControl alloc] initWithFrame:CGRectMake(pageControlOriginX, pageControlOriginY, pageControlWidth, pageControlHeight)] autorelease];
    [self.view addSubview:_pageControl];
    _pageControl._activeImage = [UIImage imageNamed:@"icon_point_action.png"];
    _pageControl._inactiveImage = [UIImage imageNamed:@"icon_point.png"];
    _pageControl._itemDis = 20;
    _pageControl._numberOfPages = [guidePageArray count];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
  
    [self updateContents:guideScrollView];
    
    _headImageView.contentMode = UIViewContentModeScaleAspectFit;
    //_headImageView.backgroundColor = [UIColor redColor];
}
-(void)updateContents:(UIScrollView *) scrollView
{
    float width = scrollView.frame.size.width;
    float offsetX = scrollView.contentOffset.x;
    float pageIndexFloat = offsetX / width + 0.5;
    int page = pageIndexFloat;
    float sigin = pageIndexFloat - page > 0.5 ? 1 : -1;
    float offsetDelaX = offsetX - page * width;
    
    CGRect buttonContainerFrame = _buttonContainer.frame;
    float buttonMinOriginY = _buttonContainerOriginFrame.origin.y;
    float buttonOffsetY = (self.view.frame.size.height - _buttonContainerOriginFrame.origin.y) * (offsetDelaX / scrollView.frame.size.width * 2);
    //NSLog(@"%f   %f",offsetDelaX,pageIndexFloat - page);
    buttonContainerFrame.origin.y  = buttonMinOriginY + sigin * buttonOffsetY;
    _buttonContainer.frame = buttonContainerFrame;
    
    CGRect headImageFrame = _headImageView.frame;
    float headMinOriginY = _headImageOriginFrame.origin.y;
    float headOffsetY = (headMinOriginY + _headImageOriginFrame.size.height) * (offsetDelaX / scrollView.frame.size.width * 2);
    
    headImageFrame.origin.y = headMinOriginY - sigin * headOffsetY;
    _headImageView.frame = headImageFrame;
    NSArray * guidePageArray = [self._configDic objectForKey:@"guideConfigs"];
    
    if(page >= 0 && page < [guidePageArray count])
    {
        NSDictionary * dic = [guidePageArray objectAtIndex:page];
        _headImageView.image = [UIImage imageNamed:[dic objectForKey:@"guide_img"]];
    }
    else
    {
        _headImageView.image = 0;
    }
    
}
-(void)registButtonClicked
{
    [self saveToFile];
    if(self._delegate)
    {
        [self._delegate registButtonClicked:self];
    }
}
-(void)loginButtonClicked
{
    [self saveToFile];
    if(self._delegate)
    {
        [self._delegate loginButtonClicked:self];
    }
}
#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float width = scrollView.frame.size.width;
    float offsetX = scrollView.contentOffset.x;
    int page = offsetX / width + 0.5;
    page = page > 0 ? page : 0;
    page = page < _pageControl._numberOfPages  - 1 ? page : _pageControl._numberOfPages - 1;
    
    [_pageControl updateCurrentPageIndex:page];
    //
    [self updateContents:scrollView];
}



@end
