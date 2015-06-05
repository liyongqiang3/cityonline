//
//  CityHot.h
//  CityEconomyOnline
//
//  Created by a on 13-12-2.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityHot : NSObject<NSCoding>

@property (copy,nonatomic) NSString * cityHotTitle ; // 热点标题

@property (copy,nonatomic) NSString * cityHotID ; // 热点id

@property (copy,nonatomic) NSString * imagePath ; // 图片路径 ；

@property (retain,nonatomic) UIImage * image  ; // 图片




@end
