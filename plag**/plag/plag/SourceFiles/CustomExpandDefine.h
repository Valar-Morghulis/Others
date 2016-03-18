#ifndef CustomExpandDefine_H
#define CustomExpandDefine_H

//for CEDynamicDataManager

#define CE_DYNAMIC_DATA_FIILE_NAME @"ceDynamicData.txt"

//for CENavBar

#define CE_NAVBAR_TAG_START 1000//tag标记起点
#define CE_TYPEINDEX_NONE -1 //
#define CE_DEFAULT_ITEM_WIDTH 66//默认宽度
#define CE_DEFAULT_ITEM_HEIGHT 66//默认高度


//for CETableList

#define DEFAULT_CE_TABLELIST_SECTION_HEADER_HEIGHT 30
#define DEFAULT_CE_TABLELIST_CELL_HEIGHT 120
#define DEFAULT_CE_TABLELIST_WIDTH 160 //默认宽度

#define DEFAULT_CE_TABLELIST_CELL_DEFAULT_IMAGE @"defaultImage.png" //默认图片
#define DEFAULT_CE_TABLELIST_CELL_COLOR_NORMAL RGBA(241,241,241,1) //普通情况下背景颜色
#define DEFAULT_CE_TABLELIST_CELL_COLOR_SELECTED RGBA(214,214,214,1) //选中后背景颜色

//for CEMoveTableList

#define DEFAULT_CE_MOVETABLELIST_CELL_COLOR_NORMAL RGBA(255,255,255,0) //普通情况下背景颜色
#define DEFAULT_CE_MOVETABLELIST_CELL_COLOR_SELECTED RGBA(255,255,255,0.2) //选中后背景颜色

#define DEFAULT_CE_MOVETABLELIST_SPLIT_COLOR_NORMAL RGBA(255,255,255,0.5) //普通情况下背景颜色
#define DEFAULT_CE_MOVETABLELIST_SPLIT_COLOR_SELECTED RGBA(255,255,255,0.3) //选中后背景颜色

#define DEFAULT_CE_MOVETABLELIST_UNUSED_COLOR_NORMAL RGBA(255,255,255,0.5) //普通情况下背景颜色
#define DEFAULT_CE_MOVETABLELIST_UNUSED_COLOR_SELECTED RGBA(255,255,255,0.3) //选中后背景颜色


#define DEFAULT_CE_MOVETABLELIST_ANIMATION_DURATION_TIME 0.3f

#define DEFAULT_CE_MOVETABLELIST_SECTION_HEIGHT 56


#define DEFAULT_CEMAIN_SETTINGLIST_CELL_HEIGHT 50
#define DEFAULT_CEMAIN_SETTINGLIST_SPLIT_CELL_HEIGHT 16

#define DEFAULT_CEMAIN_SETTINGLIST_WIDTH 200


//for CEGuideViewController
#define GUIDE_CONFIG_FILE_NAME @"GCGuideConfig"                     //引导页配置文件
#define GUIDE_CONFIG_FILE_TYPE @"txt"

//for CEWaterfallViewCell
#define CEWaterfallViewCell_DefaultImage DEFAULT_EMPTY_IMAGE //默认图片

//for CEWaterfallViewCell
typedef enum CEWaterfallViewCellType
{
    CEWaterfallViewCellType_None,//
    CEWaterfallViewCellType_Text,//文本
    CEWaterfallViewCellType_Normal
}CEWaterfallViewCellType;


//for CEDefaultCityManager

#define  MAP_DEFAULT_CITY_CONFIG_FILE_NAME @"ceDefaultCity"
#define MAP_DEFAULT_CITY_CONFIG_FILE_TYPE @"txt"





#endif