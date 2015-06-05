//
//  BigImage.h
//  CityEconomyOnline
//
//  Created by a on 13-12-10.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BigImage : NSObject
@property (copy,nonatomic) NSString * imageId ; // 图片id
@property (copy,nonatomic) NSString * imageTitle ;// 图片的title
@property (copy,nonatomic) NSString * imageUrl ;//图片的路径
@property (copy,nonatomic) UIImage * image ;      // 图片image

@end
