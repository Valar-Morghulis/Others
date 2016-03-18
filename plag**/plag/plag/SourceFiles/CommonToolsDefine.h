#ifndef CommonToolsDefine_H
#define CommonToolsDefine_H

//平台相关
#define APP_KEY  @"610120"
//#define SERVER_KEY  @"610112"
#define API_VERSION  @"1"
#define CHANNEL_ID  @"10001"
#define APP_SECRET @"ShpMn3Q28FrBgqUXodVAf1uZN7e5bsmc"
//
#define USED_TEST 0//
#if USED_TEST
#define CTNETWORK_SERVER_URL @"http://192.168.2.156:10000/platform/api"//服务器网址 ----- 外网
extern NSString * CTIMG_BASEURL;//图片基础路径
#else
#define CTNETWORK_SERVER_URL @"http://182.48.115.36:8080/platform/api"//服务器网址 ---- 内网
extern NSString * CTIMG_BASEURL; //图片基础路径
#endif



#define CTNetworkCancleHTTPConnectionKey				@"CTNetworkCancleHTTPConnection"
//

#define CTDismissWithAlertViewKey                 @"CTDismissWithAlertView"
#define CTWaitingViewTapRecognizerClickedKey                        @"CTWaitingViewTapRecognizerClicked"
//
#define CTAddStartViewKey                              @"CTAddStartView"
#define CTRemoveStartViewKey                        @"CTRemoveStartView"

#define CTAddWaitingViewKey                              @"CTAddWaitingView"
#define CTRemoveWaitingViewKey                        @"CTRemoveWaitingView"

#define CTPushViewControllerKey						@"CTPushViewController"
#define CTPopViewControllerKey						@"CTPopViewController"
#define CTPopToRootViewControllerKey				@"CTPopToRootViewController"
#define CTOpenPresentModelViewControllerKey         @"CTOpenPresentModelViewController"
#define CTDissmissModalViewContollerKey        @"CTDissmissModalViewContoller"

#define CTHideNavigationBarKey                              @"CTHideNavigationBar"



//for CTBaseViewController

#define ErrorTip_Default	@"抱歉，您的网络无法连通，请您检查网络设置后重试。"
#define ErrorTip_TimeOut	@"抱歉，请求超时，请您检查网络设置后重试。"
#define ErrorTip_404		@"抱歉，服务器正在维护，请您稍后重试。"

#define DEFAULT_LEFTBUTTON_NORMAL_IMAGE @"unsel_back.png"
#define DEFAULT_LEFTBUTTON_HIGHLIGHT_IMAGE @"sel_back.png"
#define DEFAULT_RIGFHTBUTTON_NORMAL_IMAGE @"unsel_home.png"
#define DEFAULT_RIGHTBUTTON_HIGHLIGHT_IMAGE @"sel_home.png"

//for CTNavigationController

#define CTNAVIGATIONCONTROLLER_BECKGROUNDIMAGE @"title.png"
#define NAVIGATIONCONTROLLER_BACKGROUNDVIEW_TAG 20000

//for CTWebService

#define CTWebTileRetries  0
#define ISMaxConcurrentConnections  10
#define DEFAULT_TIMEOUTINTERVAL 60//超时时间
#define CTWebServiceErrorDomain @"CTWebServiceErrorDomain"
#define CTWebServiceHTTPResponseCodeKey @"CTWebServiceHTTPResponseCodeKey"
#define CTWebServiceNotificationErrorKey @"CTWebServiceNotificationErrorKey"

//for CTRefreshTableHeaderView

#define CTREFRESHTABLEHEADERVIEW_IMAGE  @"blueArrow.png"

//for CTDownload

#define kTHDownLoadTask_TempSuffix  @".TempDownload"

//for CTDownImageView
#define DEFAULT_EMPTY_IMAGE @"defaultEmptyImage.png"
#define DEFAULT_BACKGROUNDCOLOR  RGBA(244,244,244,1)

//for CTPageControl

#define CTPAGECONTROL_ACTIVEIMAGE @"sel_round.png"
#define CTPAGECONTROL_INACTIVEIMAGE @"unsel_round.png"

#define CTPAGECONTROL_ACTIVECOLOR RGBA(255,166,58,1)
#define CTPAGECONTROL_INACTIVECOLOR RGBA(204,204,204,1)
//for CTUDIDTools

#define kKeychainUDIDItemIdentifier "UUID"
#define kKeyChainUDIDAccessGroup  "83KC7TE42W.com.BIPT"

//for CTAlertView

#define CTALERTVIEW_BACKGROUNDIMAGE @"bg_alert.png"
#define CTALERTVIEW_GRAYBUTTONIMAGE @"btn_alert_gray.png"
#define CTALERTVIEW_ACTIONBUTTONIMAGE @"btn_alert_action.png"
#define CTALERTVIEW_NORMALBUTTONIMAGE @"btn_alert_normal.png"
#define CTALERTVIEW_TEXTCOLOR RGBA(85.0, 85.0, 85.0, 1)




#endif