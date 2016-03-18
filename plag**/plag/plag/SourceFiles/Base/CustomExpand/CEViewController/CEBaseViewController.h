//
//  CEBaseViewController.h
//  Shopping_Mall
//
//  Created by yaoyongping on 13-9-24.
//
//

#import "CTBaseViewController.h"
#import "CTDownImageView.h"

@interface CEBaseViewController : CTBaseViewController<CTDownImageViewDelegate>
{
    NSDictionary * _data;
}
@property(nonatomic,retain) NSDictionary * _data;
@end
