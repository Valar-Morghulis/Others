//
//  CTRefreshConst.h
//  CTRefresh
//
//  Created by CT on 14-1-3.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#ifdef DEBUG
#define CTLog(...) NSLog(__VA_ARGS__)
#else
#define CTLog(...)
#endif

// 文字颜色
#define CTRefreshLabelTextColor [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0]

extern const CGFloat CTRefreshViewHeight;
extern const CGFloat CTRefreshAnimationDuration;

extern NSString *const CTRefreshBundleName;
#define kSrcName(file) [CTRefreshBundleName stringByAppendingPathComponent:file]

extern NSString *const CTRefreshFooterPullToRefresh;
extern NSString *const CTRefreshFooterReleaseToRefresh;
extern NSString *const CTRefreshFooterRefreshing;

extern NSString *const CTRefreshHeaderPullToRefresh;
extern NSString *const CTRefreshHeaderReleaseToRefresh;
extern NSString *const CTRefreshHeaderRefreshing;
extern NSString *const CTRefreshHeaderTimeKey;

extern NSString *const CTRefreshContentOffset;
extern NSString *const CTRefreshContentSize;