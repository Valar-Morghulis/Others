//
//  APP_GlobeDefine.h
//  BIPT_MoblieOfficce
//
//  Created by Thinkfer on 14-1-5.
//  Copyright (c) 2014年 Thinkfer. All rights reserved.
//

#ifndef APP_GlobeDefine_h
#define APP_GlobeDefine_h

//
#define RGBA(r,g,b,a)							[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define ToString( var ) #var
#define ToNSString(var) ([NSString stringWithUTF8String:ToString(var)])


//for leanCloud
#define kApplicationId @"TYsErg37ozzqVfcqbtapMPgJ"
#define kClientKey @"vJIxfmsp510sAozOQuWYibid"
static NSString *const kCDNotificationMessageDidSent = @"MessageDidSent";//消息已经发送完成


//版本号
#define APP_VERSION 104
#define APP_VERSION_STRING @"1.0.4"
//微信
#define USED_WECHAT 1
#define WECHAT_AppID @"wxc6b871697446ab6c"
#define WECHAT_AppSecret @"03f86b15ff2c6e3098c9df52226442f9"

//是否使用更新
#define USED_CHECK_UPDATE 1 //更新
#define USED_FIR_IM_UPDATE 1 //使用fir.im作为更新来源

//平台相关
//#define APP_KEY  @"101000"
#define APP_KEY @"101007"

//#define SERVER_KEY  @"610112"
#define API_VERSION  @"1"
#define CHANNEL_ID  @"10001"
#define APP_SECRET @"ShpMn3Q28FrBgqUXodVAf1uZN7e5bsmc"

#define APP_IMEI @"358148045937138"
#define APP_IMSI @"460002950531203"
//

//网络设置
#define USED_UAT 0//
#if USED_UAT
#define CTNETWORK_SERVER_URL @"http://121.42.25.196:8080/vcardAPI/api/"//服务器网址 ---- 内网
#else
#define CTNETWORK_SERVER_URL @"http://47.88.6.109:8080/vcardAPI/api/"//服务器网址 ----- 外网

#endif

//for qiniu
#define QINIU_ACCESSKEY @"amZ4ByXbKrskckV3U22l7U6MZrFj60dcqG-l-r8k"
#define QINIU_SECRETKEY @"VKe9sXa0kP8OLzFfzkZzUt4s_YB9Hi0cSaC3D2DC"
#define QINIU_BUCKET @"avatar"


//通知

#define CTNetworkCancleHTTPConnectionKey				@"CTNetworkCancleHTTPConnection"
//

#define CTAddStartViewKey                              @"CTAddStartView"//启动页面
#define CTRemoveStartViewKey                        @"CTRemoveStartView"

#define CTAddWaitingViewKey                              @"CTAddWaitingView"//加载中..
#define CTRemoveWaitingViewKey                        @"CTRemoveWaitingView"


#define CTShowLoginPageKey @"CTShowLoginPageKey" //登录

#define CTUserAvatarChangedKey @"CTUserAvatarChangedKey" //用户头像修改


//for PStackCardList
extern float PStackCardMaxWidth;//卡片最大宽度
extern float PStackCardMinWidth;//卡片最小宽度
extern float PStackCardMaxHeight;//卡片最大高度，对应 PStackCardMaxWidth

extern float PStackCardRefrenceY; //起点空白高度
extern int PStackCardMaxCountPerScreen; //单屏最多显示个数
#define PStackCardTimeInterval 0.02//
#define PStackCardAcceleration -1000//加速度

//for PSlideCardList
#define PSlideCardMinCellHeight 140.0
#define PSlideCardMaxCellHeight 250.0//


#define USED_PStartView 0//



//地图服务

#define MAP_BAIDU                   1                            //百度地图
#define MAP_GOOGLE                  2                            //google地图
#define MAP_TYPE                    0                    //指定地图类型


#define MAP_VERSION                 270                            //指定地图版本号
#define MAP_VERSION_STRING          @"v2.7.0"                 //指定显示版本号字符串


//

#define MAP_KEY @"Kpr2qDRoSX5rtE6FvPgx3zGa"         //key

#if MAP_TYPE == MAP_BAIDU                                         //百度地图下的一些定义
#import <BaiduMapAPI/BMapKit.h>

//MapManager
#define GCMapManager               BMKMapManager
#define GCMapManagerDelegate       BMKGeneralDelegate

//MapView
#define GCMapView                  BMKMapView
#define GCMapViewDelegate          BMKMapViewDelegate

//Geometry
#define GCCoordinateRegion         BMKCoordinateRegion
#define GCCoordinateSpan           BMKCoordinateSpan
#define GCMapRect                  BMKMapRect
#define GCZoomScale                BMKZoomScale
#define GCUserLocation  BMKUserLocation
//Annotation
#define GCAnnotation               BMKAnnotation
#define GCShape                    BMKShape
#define GCPointAnnotation          BMKPointAnnotation


//AnnotationView
#define GCAnnotationView           BMKAnnotationView
#define GCPinAnnotationView        BMKPinAnnotationView
#define GCPinAnnotationColorPurple BMKPinAnnotationColorPurple

//Overlay
#define GCOverlay                  BMKOverlay
#define GCPolyline                 BMKPolyline

//OverlayView
#define GCOverlayView              BMKOverlayView
#define GCPolylineView             BMKPolylineView

//OfflineMap
#define GCOLSearchRecord          BMKOLSearchRecord
#define GCOLUpdateElement         BMKOLUpdateElement
#define GCOfflineMapDelegate      BMKOfflineMapDelegate
#define GCOfflineMap              BMKOfflineMap



#elif  MAP_TYPE == MAP_GOOGLE                                     //google地图下的一些定义

#import <MapKit/MapKit.h>
#import "GMKMapManager.h"
#import "GMKOfflineMap.h"
//MapManager
#define GCMapManager               GMKMapManager
#define GCMapManagerDelegate       GMKMapManagerDelegate
//MapView
#define GCMapView                  MKMapView
#define GCMapViewDelegate          MKMapViewDelegate

//Geometry
#define GCCoordinateRegion         MKCoordinateRegion
#define GCCoordinateSpan           MKCoordinateSpan
#define GCMapRect                  MKMapRect
#define GCZoomScale                MKZoomScale
#define GCUserLocation  MKUserLocation

//Annotation
#define GCAnnotation               MKAnnotation
#define GCShape                    MKShape
#define GCPointAnnotation          MKPointAnnotation


//AnnotationView
#define GCAnnotationView           MKAnnotationView
#define GCPinAnnotationView        MKPinAnnotationView
#define GCPinAnnotationColorPurple MKPinAnnotationColorPurple

//Overlay
#define GCOverlay                  MKOverlay
#define GCPolyline                 MKPolyline

//OverlayView
#define GCOverlayView              MKOverlayView
#define GCPolylineView             MKPolylineView



//OfflineMap
#define GCOLSearchRecord          GMKOLSearchRecord
#define GCOLUpdateElement         GMKOLUpdateElement
#define GCOfflineMapDelegate      GMKOfflineMapDelegate
#define GCOfflineMap              GMKOfflineMap




#endif





#endif
