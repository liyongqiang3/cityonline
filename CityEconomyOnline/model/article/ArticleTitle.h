//
//  ArticleTitle.h
//  CityEconomyOnline
//
//  Created by a on 13-11-27.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleTitle : NSObject<NSCoding>

@property (copy,nonatomic) NSString * title ; // 标题

@property (copy,nonatomic) NSString * updatedtime ; // 更新 时间

@property (copy,nonatomic) NSString * articleId ; // 文章id 


@end
