//
//  MoreVideo.h
//  CityEconomyOnline
//
//  Created by a on 13-12-4.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoreVideo : NSObject<NSCoding>

@property (copy,nonatomic) NSString * videoId ; // 视频得id

@property (copy,nonatomic) NSString * videoTitle ;//视频标题

@property (copy,nonatomic) NSString * filepath ;// 视频文件路径

@property (copy,nonatomic) NSString * picturepath ;//图片得路径

@property (copy,nonatomic) NSString  * createDate ; //创建时间

@property (copy,nonatomic) NSString * cityId ; //城市id

@property (copy,nonatomic) NSString * usagetype;// 视频栏目 类型 

@property (retain,nonatomic)UIImage * image ; // 图片

@property (retain,nonatomic) NSString * subtitle ; // 副标题

@property (retain,nonatomic) NSString * desp ;// 描述 

@end
