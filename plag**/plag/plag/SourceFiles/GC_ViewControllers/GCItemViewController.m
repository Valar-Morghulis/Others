//
//  GCItemViewController.m
//  plag
//
//  Created by MaYing on 15/6/3.
//  Copyright (c) 2015年 xiaofu. All rights reserved.
//

#import "GCItemViewController.h"

#import "GCMapViewController.h"

#define BarData @"{\"array\":[{\"index\":0,\"title\":\"商品\"},{\"index\":1,\"title\":\"商家\"},{\"index\":2,\"title\":\"评论\"},{\"index\":3,\"title\":\"地图\"}]}"



@implementation GCItemViewController

@synthesize _itemBar;
@synthesize _scrollView;

-(void)dealloc
{
    self._scrollView = 0;
    self._itemBar = 0;
    [super dealloc];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    //
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect frame = self.view.frame;

    //
    float backOriginX = 16;
    float backOriginY = 16;
    float backWidth = 32;
    float backHeight = backWidth;
    UIButton * backButton = [[[UIButton alloc] initWithFrame:CGRectMake(backOriginX, backOriginY, backWidth, backHeight)] autorelease];
    //[self.view addSubview:backButton];
    [backButton addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"back_action.png"] forState:UIControlStateSelected];
    [backButton setImage:[UIImage imageNamed:@"back_action.png"] forState:UIControlStateHighlighted];
    //
    
    float barHeight = 54;
    float barOriginY = frame.size.height - barHeight - 18;
    float barWidth = frame.size.width;
    float barOriginX = 0;
    self._itemBar = [[[GCItemBar alloc] initWithFrame:CGRectMake(barOriginX, barOriginY, barWidth, barHeight)] autorelease];
    [self.view addSubview:self._itemBar];
    float leftDis = 25;
    float itemWidth = barHeight;
    NSArray * items = [[BarData yajl_JSON] objectForKey:@"array"];
    float itemDis = (barWidth - leftDis * 2 - itemWidth * [items count]) / ([items count] - 1);
    self._itemBar._leftDis = leftDis;
    self._itemBar._itemWidth = itemWidth;
    self._itemBar._itemDis = itemDis;
    self._itemBar._key = @"index";
    self._itemBar._delegate = self;
    self._itemBar._items = items;
    //
    self._scrollView = [[[UIScrollView alloc] initWithFrame:self.view.bounds] autorelease];
    [self.view insertSubview:self._scrollView atIndex:0];//
    self._scrollView.delegate = self;
    self._scrollView.pagingEnabled = TRUE;
    self._scrollView.showsVerticalScrollIndicator = FALSE;
    
    [self makeContents];
    //
    [self._itemBar selectItemByTypeIndex:0 animate:TRUE];
}
-(void)makeContents
{
    CGRect scrollFrame = self._scrollView.frame;
    float contentScrollOriginX = 0;
    float contentScrollWdith = scrollFrame.size.width;
    float contentScrollOriginY = 0;
    float contentScrollHeight = scrollFrame.size.height;
    
    NSString * images[4] = {@"商品.jpg",@"商家.jpg",@"评论.jpg",@"地图.jpg"};
    for(int i = 0;i < 4;i++)
    {
        UIScrollView * contentScroll = [[[UIScrollView alloc] initWithFrame:CGRectMake(contentScrollOriginX, contentScrollOriginY, contentScrollWdith, contentScrollHeight)] autorelease];
        [self._scrollView addSubview:contentScroll];
        contentScroll.showsVerticalScrollIndicator = FALSE;
        //
        UIImage * image = [UIImage imageNamed:images[i]];
        CGRect imageViewFrame = contentScroll.bounds;
        imageViewFrame.size.height = image.size.height / 2;
        UIImageView * imageView = [[[UIImageView alloc] initWithFrame:imageViewFrame] autorelease];
        imageView.image = image;
        [contentScroll addSubview:imageView];
        UIButton *button = [[[UIButton alloc] initWithFrame:imageViewFrame] autorelease];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 1024 + i;
        [contentScroll addSubview:button];
        
        //
        contentScroll.contentSize = CGSizeMake(contentScrollWdith, imageViewFrame.size.height);
        //
        contentScrollOriginY += contentScrollHeight;
    }
    
    CGSize contentSize = self._scrollView.contentSize;
    contentSize.height = contentScrollOriginY;
    self._scrollView.contentSize = contentSize;
}

-(void)buttonClicked:(UIButton *)button
{
    long i = button.tag - 1024;
    if(i == 3)//地图
    {
        GCMapViewController * controller = [[GCMapViewController alloc] init];
        [self pushViewController:controller animate:TRUE];
        [controller release];
    }
}

#pragma mark CENavBarDelegate
-(void)itemSelected:(CENavBarItemView *)item data:(NSDictionary *)data
{
    CGRect scrollFrame = self._scrollView.frame;
    CGPoint contentOffset = self._scrollView.contentOffset;
    contentOffset.y = [[data objectForKey:@"index"] intValue] * scrollFrame.size.height;
    [self._scrollView setContentOffset:contentOffset animated:TRUE];
}
-(void)itemUnselected:(CENavBarItemView *)item data:(NSDictionary *)data{}

-(void)backClicked
{
    [self back:0];
}


#pragma mark UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float height = scrollView.frame.size.height;
    float offsetY = scrollView.contentOffset.y;
    int index = offsetY / height + 0.5;
    [self._itemBar selectItemByTypeIndex:index animate:FALSE];
}


@end
