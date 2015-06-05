//
//  NewesVideo.h
//  CityEconomyOnline
//
//  Created by a on 13-11-27.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewesVideo : NSObject<NSCoding>

@property (copy,nonatomic) NSString  * newesId ; // 视频的id

@property (copy,nonatomic) NSString * title ;  // 标题

@property (copy,nonatomic) NSString * moveUrl ; // 电影的url

@property (copy,nonatomic) NSString * imagePath ; // 图片的url

@property (strong,nonatomic) UIImage * image ; // 标题图片 ；



@end
