//
//  CitytipsImage.h
//  CityEconomyOnline
//
//  Created by a on 13-12-3.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CitytipsImage : NSObject<NSCoding>

@property (copy,nonatomic) NSString *  citytipsTitle ;// 标题 

@property (copy,nonatomic) NSString * imageUrl  ; // 城市得URL

@property (retain,nonatomic) UIImage * citytipsImage ;// 城市图片

@property (retain,nonatomic) NSString * cityID ; // 城市id

@end
