//
//  ArticleDetail.h
//  CityEconomyOnline
//
//  Created by liyongqiang on 13-11-27.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleDetail : NSObject<NSCoding>

@property (copy) NSString * articleid ; //  文章id

@property (copy) NSString * title ; // 文章标题

@property (copy) NSString * createdDate ; // 发表时间

@property (copy) NSString * updatedDate ;// 发布时间
 
@property (copy) NSString * city ; // 城市

@property (copy) NSString * usagetype ; // 所在类型

@property (copy) NSString * content ; // 文章内容

@property (copy) NSString * subtitle ;// 子标题


@end
