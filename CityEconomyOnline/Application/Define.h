//
//  Define.h
//  CityEconomyOnline
//
//  Created by Tsoftime on 13-8-14.
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
#define kRightFrame   CGRectMake(90,0,934,748)

#define kDefaultSliderTime  @"DefaultSliderPhotoChangeTime"
#define HOST @"http://198.56.248.157:3000"


#endif
