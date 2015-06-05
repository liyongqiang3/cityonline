//
//  DefineType.h
//  CityEconomyOnline
//
//  Created by a on 13-11-23.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//


#ifndef CityEconomyOnline_Define_h
#define CityEconomyOnline_Define_h

#ifdef DEBUG
#define CLog(format, ...) NSLog(format,##__VA_ARGS__)
#else
#define CLog(format, ...)
#endif

#define originX(view) view.frame.origin.x
#define originY(view) view.frame.origin.y
#define width(view)   view.frame.size.width
#define height(view)  view.frame.size.height

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define systemVersionValue [[[UIDevice currentDevice] systemVersion] floatValue]

#define kLeftViewWidth 91
#define kRightFrame   CGRectMake(90,60,934,748)

#define kDefaultSliderTime  @"Defau；3ltSliderPhotoChangeTime"
#define HOST @"http://113.11.199.86" //@"http://192.168.51.38:3000"
// @"http://113.11.199.86"


#define SCREEN_WIDTH  1024 
#define SCREEN_HEIGHT 768 

typedef enum
{
    VideoRecommend = 0, // 视频推荐
    TravelVideo,   // 旅游视频
    Leadertalk,    // 领导谈话
    PulseCity,      //把脉城市
    HotspotDialogue,// 热点对话
    CityMicroFilm,  // 城市微电影
    PublicWelfareAd, //公益广告
    FocusSpecial     //焦点专题
}Videotype;
//旅游照片
#define TRAVEL_PICTURES @"travelPictures"
//旅游视频
#define TRAVEL_VIDEO @"travelVideos"
//攻略推荐
#define STRATERGY_RECOMMENT @"stratergyRecomment"
// 城市微电影
#define CITY_MICROFLIM @"cityMicroFlim"
// 公益广告npublic service advertising
#define PUBLIC_SERVICE_AD  @"publicSevvi"
// 焦点专题
#define FOCUS_SPRCIAL @"focusSpcial"
//领导访谈
#define LEADER_TALK @"leaderTalk"
// 把脉城市
#define PLUSE_City @"pluseCity"
//热点 对话
#define HOTT_ALK @"HOTTALK"

// 城市对话
#define CITY_DIAlOGUE @"cityDialogue"
//微城市
#define MICRO_CITY @"microCity"

// 城市热点
#define CITY_HOTSPOT @"cityHotspot"

// 视频推荐
#define VIDEO_RECOMMENT @"videoRecomment"
// 城市焦点
#define CITY_FOCUS @"Cityfocus"
// 我的旅游图片
#define OWNER_IMAGES @"OwnerImages"

// 回到主页
#define BACK_HOME @"blackHome"

//时间停止
#define STOPTIME @"stop_time"



#endif
