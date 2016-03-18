//
//  CENavBar.m
//  GX_GuangShopping
//
//  Created by yaoyongping on 13-9-25.
//
//

#import "CENavBar.h"

@implementation CENavBar
@synthesize _key;
@synthesize _delegate;
@synthesize _currentItem;
@synthesize _items;
@synthesize _typeIndex;
@synthesize _itemWidth;
@synthesize _scrollView;
@synthesize _prototypeNavBarItemView;
@synthesize _autoAdjustItemFrame;
@synthesize _itemDis;
@synthesize _leftDis;

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self._key = @"navigationType";
        // Initialization code
        _autoAdjustItemFrame = FALSE;//默认false
        _itemDis = 0;//默认0
        _leftDis = 0;//默认0
        _typeIndex = CE_TYPEINDEX_NONE;//
        _itemWidth = CE_DEFAULT_ITEM_WIDTH;
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [scrollView setShowsHorizontalScrollIndicator:NO];
        [scrollView setShowsVerticalScrollIndicator:NO];
        [self addSubview:scrollView];
        self._scrollView = scrollView;
        self._scrollView.delegate = self;
        [scrollView release];
        self._scrollView.backgroundColor = [UIColor clearColor];
        self._prototypeNavBarItemView = [[[CENavBarItemView alloc] initWithFrame:CGRectZero] autorelease];
    }
    return self;
}
-(void)dealloc
{
    self._items = 0;//首先
    self._scrollView = 0;
    self._currentItem = 0;
    self._prototypeNavBarItemView = 0;
    self._key = 0;
    [super dealloc];
}
-(int)_typeIndex
{
    assert(self._key);
    int result = CE_TYPEINDEX_NONE;
    if(self._currentItem)
    {
        NSDictionary * dic = self._currentItem._data;
        result = [[dic objectForKey:self._key]  intValue];
    }
    return result;
}
-(void)set_items:(NSArray *)items
{
    if(_items != items)
    {
        if (_items)
        {
            [_items release];
        }
        _items = items;
        if(_items)
        {
            [_items retain];
        }
    }
    //什么都不选
    [self selectItemByTypeIndex:CE_TYPEINDEX_NONE animate:FALSE];
    //移除之前的
    NSArray * subViews = [self._scrollView subviews];
    for(UIView * view in subViews)
    {
        [view removeFromSuperview];
    }
    //添加新的
    int i = 0;
    float originXCount = self._leftDis;
    for (NSDictionary *dic in items)
    {
         CENavBarItemView * item = [self._prototypeNavBarItemView deepCopy];
        float width = _itemWidth;
        CGRect targetFrame = CGRectMake(originXCount, 0, width, self._scrollView.frame.size.height);
        if(self._autoAdjustItemFrame)
        {
            targetFrame = [item autoAdjustFrame:targetFrame data:dic];
        }
        originXCount += targetFrame.size.width;
        
        [item  initlizeWithFrame:targetFrame];
        item.tag = i + CE_NAVBAR_TAG_START;
        [self._scrollView addSubview:item];
        item._delegate = self;
        item._data = dic;
        i++;
        originXCount += self._itemDis;
    }
    if(i > 0)
    {
        originXCount -= self._itemDis;
    }
    originXCount += self._leftDis;
    [self._scrollView setContentSize:CGSizeMake(originXCount, self._scrollView.frame.size.height)];

}

#pragma mark CENavBarItemViewDelegate
-(void)itemSelected:(CENavBarItemView *)item data:(NSDictionary *)data
{
    if(self._currentItem && self._currentItem != item)
    {
        [self._currentItem setUnselected:FALSE];
        if(self._delegate)
        {
            [self._delegate itemUnselected:self._currentItem data:self._currentItem._data];
        }
    }
    //
    if(self._delegate)
    {
        [self._delegate itemSelected:item data:data];
    }
    self._currentItem = item;
}

-(void)itemUnselected:(CENavBarItemView *)item data:(NSDictionary *)data
{
    self._currentItem = 0;
    
    if(self._delegate)
    {
        [self._delegate itemUnselected:item data:data];
    }
}
-(CENavBarItemView *)itemWithTypeIndex:(int)typeIndex
{
    int itemIndexInScrollView = -1;
    for(int i = 0;i < [_items count];i++)
    {
        NSDictionary *dic  = [_items objectAtIndex:i];
        int itemIndex = [[dic objectForKey:self._key]  intValue];
        if(itemIndex == typeIndex)
        {
            itemIndexInScrollView = i;
            break;
        }
    }
    
    int itemViewTag = itemIndexInScrollView + CE_NAVBAR_TAG_START;
    CENavBarItemView * itemView = (CENavBarItemView *)[self._scrollView viewWithTag:itemViewTag];
    return itemView;
}


-(void)selectItemByTypeIndex:(int)typeIndex animate:(BOOL)animate
{
    assert(self._key);
    if(self._currentItem)
    {
        [self._currentItem setUnselected:FALSE];
        self._currentItem = 0;
    }
    
    CENavBarItemView * itemView = [self itemWithTypeIndex:typeIndex];
    if(itemView)
    {
        if(!animate)
        {
            self._currentItem = itemView;
        }
        [itemView setSelected:animate];
    }
    
}


@end
