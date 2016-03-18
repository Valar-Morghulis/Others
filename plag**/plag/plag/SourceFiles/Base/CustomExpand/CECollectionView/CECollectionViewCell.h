//
// CECollectionViewCell.h


#import <UIKit/UIKit.h>

@interface CECollectionViewCell : UIView
{
    NSString * _reuseIdentifier;//用于复用
}
@property(nonatomic,readonly)NSString * _reuseIdentifier;

@property (nonatomic, retain) id object;
-(id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier;//复用

- (void)prepareForReuse;
- (void)fillViewWithObject:(id)object;
+ (CGFloat)heightForViewWithObject:(id)object inColumnWidth:(CGFloat)columnWidth;

@end
