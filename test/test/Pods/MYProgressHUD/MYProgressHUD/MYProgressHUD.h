//
//  MYProgressHUD.h


#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@protocol MYProgressHUDDelegate;

@interface MYProgressHUD : MBProgressHUD
{
    //add by my
    BOOL _canCancel;
    UITapGestureRecognizer * _tapRecoginzer;
}
@property(nonatomic,readwrite) BOOL _canCancel;


+ (MYProgressHUD *)showHUDAddedTo:(UIView *)view animated:(BOOL)animated canCancel:(BOOL)canCancel;

#if __has_feature(objc_arc_weak)
@property (weak) id<MYProgressHUDDelegate> delegate;
#elif __has_feature(objc_arc)
@property (unsafe_unretained) id<MYProgressHUDDelegate> delegate;
#else
@property (assign) id<MYProgressHUDDelegate> delegate;
#endif

@end

@protocol MYProgressHUDDelegate <MBProgressHUDDelegate>

-(void)hudWasTaped:(MYProgressHUD *)hud;
@end



