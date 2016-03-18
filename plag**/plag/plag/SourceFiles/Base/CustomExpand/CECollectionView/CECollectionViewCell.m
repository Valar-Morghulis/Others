//
// CECollectionViewCell.m


#import "CECollectionViewCell.h"

@interface CECollectionViewCell ()

@end

@implementation CECollectionViewCell
@synthesize _reuseIdentifier;
@synthesize
object = _object;
-(id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithFrame:frame])
    {
        if(reuseIdentifier)
        {
            _reuseIdentifier = [reuseIdentifier retain];
        }
    }
    return self;
}


- (void)dealloc {
    if(_reuseIdentifier)
    {
        [_reuseIdentifier release];
    }
    self.object = nil;
    [super dealloc];
}

- (void)prepareForReuse {
}

- (void)fillViewWithObject:(id)object {
    self.object = object;
}

+ (CGFloat)heightForViewWithObject:(id)object inColumnWidth:(CGFloat)columnWidth {
    return 0.0;
}

@end
