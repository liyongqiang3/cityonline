//
//  ArticleRequest.h
//  CityEconomyOnline
//
//  Created by a on 13-11-27.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleRequest : NSObject
// 详细的文章 请求
-(void)requestArticleDetailWithIndex:(NSInteger )index andArray:(NSMutableArray *)array andSucceed:(void(^)())success andFailed:(void(^)())failed ;

// 文章标题 请求 
-(void)requestArticleWithIndex:(NSInteger)index andArray:(NSMutableArray *)array andSucceed:(void(^)())success andFailed:(void(^)(NSString * errer))failed ;

// 城市热点的  图片 和标题
- (void)requestCiytHotTitleWith:(NSMutableArray *) array andSucceed:(void(^)())success andFailed:(void(^)())failed ;
// 更多列表信息
-(void)requestarticleListTitleWithArray:(NSMutableArray *)array onSucceed:(void(^)())success onFailed:(void(^)())failed ;



@end
