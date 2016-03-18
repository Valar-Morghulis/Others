//
// MYProgressHUD.m

#import "MYProgressHUD.h"


@implementation MYProgressHUD

@synthesize _canCancel;

+ (MYProgressHUD *)showHUDAddedTo:(UIView *)view animated:(BOOL)animated canCancel:(BOOL)canCancel
{
    MYProgressHUD *hud = [[MYProgressHUD alloc] initWithView:view];
    hud._canCancel = canCancel;
	[view addSubview:hud];
	[hud show:animated];
#if __has_feature(objc_arc)
	return hud;
#else
	return [hud autorelease];
#endif

}

#if !__has_feature(objc_arc)
- (void)dealloc {
    if(_tapRecoginzer)
    {
        [_tapRecoginzer release];
    }
    [super dealloc];
}
#endif


-(void)addTapRecoginzer
{
    if(!_tapRecoginzer)
    {
        _tapRecoginzer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked:)];
    }
    [self addGestureRecognizer:_tapRecoginzer];
}
-(void)removeTapRecoginzer
{
    if(_tapRecoginzer)
    {
        [self removeGestureRecognizer:_tapRecoginzer];
    }
}
-(void)clicked:(UITapGestureRecognizer *)recognizer
{
    if(self.delegate &&[self.delegate respondsToSelector:@selector(hudWasTaped:)])
    {
        [self.delegate hudWasTaped:self];
    }
}
-(void)set_canCancel:(BOOL)canCancel
{
    _canCancel = canCancel;
    if(_canCancel)
    {
        [self addTapRecoginzer];
    }
    else
    {
        [self removeTapRecoginzer];
    }
}



@end


