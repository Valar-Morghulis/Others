//
//  APP_GlobeDefine.h
//  BIPT_MoblieOfficce
//
//  Created by Thinkfer on 14-1-5.
//  Copyright (c) 2014年 Thinkfer. All rights reserved.
//

#ifndef APP_GlobeDefine_h
#define APP_GlobeDefine_h

//版本号
#define APP_VERSION 105
#define APP_VERSION_STRING @"1.0.5"
//微信
#define USED_WECHAT 1
#define WECHAT_AppID @"wxc6b871697446ab6c"
#define WECHAT_AppSecret @"03f86b15ff2c6e3098c9df52226442f9"


#define USED_CHECK_UPDATE 1 //更新

#define USED_CACHE 0//使用缓存

#define USED_REFRESHHEADER 1//使用下拉刷新


#define APP_CACHE_FOLDER           @"xfCache"                              //缓存文件夹名称
//
#define RGBA(r,g,b,a)							[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define ToString( var ) #var
#define ToNSString(var) ([NSString stringWithUTF8String:ToString(var)])






#define MAP_BAIDU                   1                            //百度地图
#define MAP_GOOGLE                  2                            //google地图

#define MAP_TYPE                    MAP_BAIDU                    //指定地图类型


#define MAP_VERSION                 270                            //指定地图版本号
#define MAP_VERSION_STRING          @"v2.7.0"                 //指定显示版本号字符串


//

#define MAP_KEY @"CWc1gSIlhuDw3YO1W5G3HQwX"         //key

#if MAP_TYPE == MAP_BAIDU                                         //百度地图下的一些定义

#import "BMapKit.h"
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
#import "GC_MKMapManager.h"
#import "GC_MKOfflineMap.h"
//MapManager
#define GCMapManager               GC_MKMapManager
#define GCMapManagerDelegate       GC_MKMapManagerDelegate
//MapView
#define GCMapView                  MKMapView
#define GCMapViewDelegate          MKMapViewDelegate

//Geometry
#define GCCoordinateRegion         MKCoordinateRegion
#define GCCoordinateSpan           MKCoordinateSpan
#define GCMapRect                  MKMapRect
#define GCZoomScale                MKZoomScale

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
#define GCOLSearchRecord          GC_MKOLSearchRecord
#define GCOLUpdateElement         GC_MKOLUpdateElement
#define GCOfflineMapDelegate      GC_MKOfflineMapDelegate
#define GCOfflineMap              GC_MKOfflineMap



#endif








#endif
