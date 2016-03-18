//
//  CTTableViewCell.h
//  XFDesigners
//
//  Created by yaoyongping on 12-12-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTDownImageView.h"
#import "CTUtility.h"

@interface CTTableViewCell : UITableViewCell<CTDownImageViewDelegate>
{
    NSDictionary *_data;
}
@property(nonatomic,retain) NSDictionary *_data;

-(void)parseData;
@end

