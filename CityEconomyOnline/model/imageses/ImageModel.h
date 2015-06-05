//
//  ImageModel.h
//  CityEconomyOnline
//
//  Created by a on 13-11-29.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageModel : NSObject<NSCoding>

@property (copy,nonatomic) NSString  * landscape_name ; // 图集名称

@property (copy,nonatomic) NSString * landscape_id ;  //图集的id

@property (copy,nonatomic) NSString * imageUrl ;   // 图片的url

@property (retain,nonatomic) UIImage * image ; // 图片

@property (copy,nonatomic) NSString * cityid ; // 城市id

@end
