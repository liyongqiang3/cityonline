//
//  ArticleRequest.m
//  CityEconomyOnline
//
//  Created by a on 13-11-27.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "ArticleRequest.h"
#import "ASIHTTPRequest.h"
#import "ArticleDetail.h"
#import "ArticleTitle.h"
#import "CityHot.h"
#import "ArticleListTitle.h"
#import "ASINetworkQueue.h"
#import "CityServer.h"
@implementation ArticleRequest


// 详细的文章 请求
-(void)requestArticleDetailWithIndex:(NSInteger )index andArray:(NSMutableArray *)array andSucceed:(void(^)())success andFailed:(void(^)())failed
{
    
    [array removeAllObjects];
    NSString * urlString = [HOST stringByAppendingFormat:@"/articles/getdetail?id=%i",index];
    NSURL * url = [NSURL URLWithString:urlString];
//    NSLog(@"_______%@",urlString);
    __unsafe_unretained ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        [self analysisArticleDetailJSONWithString:request.responseString andArray:array];
        success();
    }];
    
    ASINetworkQueue * queue = [CityServer getQueueInstance ];
    [queue addOperation:request];
//    [request startAsynchronous];
    [request  setFailedBlock:^{
        
        failed();
        
    }];
  
    
    
    
}
// 文章标题 请求
-(void)requestArticleWithIndex:(NSInteger)index andArray:(NSMutableArray *)array andSucceed:(void(^)())success andFailed:(void(^)(NSString * errer))failed
{
    [array removeAllObjects];
    NSString * urlString  = [HOST stringByAppendingFormat:@"/articles/getfocus"];
    NSURL * url = [NSURL URLWithString:urlString];
     __unsafe_unretained ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        [self analysisArticleTitleJSONWithString:request.responseString andArray:array];
        success();
    }];
    ASINetworkQueue * queue = [CityServer getQueueInstance ];
    [queue addOperation:request];
//    [request startAsynchronous ];
    [request setFailedBlock:^{
        if ([request error] != nil) {
            failed(request.responseString);
        }
       
    }];
   
}

// 解析 文章标题的
-(void)analysisArticleTitleJSONWithString:(NSString *)dataString andArray:(NSMutableArray *)array
{
    NSData * data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray * articles =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    for (NSDictionary * dic  in  articles ) {
        ArticleTitle * myArticleTitle = [[ArticleTitle alloc]init];
        myArticleTitle.title = [dic valueForKey:@"title"];
        NSString *  update = [dic valueForKey:@"updatedtime"];
        myArticleTitle.updatedtime = [update substringWithRange:NSMakeRange(0, 10)];
        myArticleTitle.articleId = [dic valueForKey:@"id"];
        [array addObject: myArticleTitle];
    }
    
                         
    
}
// 解析文章详情
-(void)analysisArticleDetailJSONWithString:(NSString *)dataString andArray:(NSMutableArray *)array
{
//    NSLog(@"%@",dataString);
    NSData * data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * articleDic =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    
    ArticleDetail * myArticleDetail = [[ArticleDetail  alloc]init];
    
    myArticleDetail.articleid = [articleDic valueForKey:@"id"];
    myArticleDetail.title = [articleDic valueForKey:@"title"];
    myArticleDetail.createdDate = [articleDic valueForKey:@"created_at"];
    myArticleDetail.updatedDate = [articleDic valueForKey:@"updated_at"];
    myArticleDetail.city = [articleDic valueForKey:@"city"];
    myArticleDetail.usagetype = [articleDic valueForKey:@"usagetype"];
    myArticleDetail.content = [articleDic valueForKey:@"content"];
    myArticleDetail.subtitle = [articleDic valueForKey:@"subtitle"];
  
    
    NSString *  imagesURl = [NSString stringWithFormat:@"src=\"%@",HOST]; // 转移字符
     myArticleDetail.content = [ myArticleDetail.content stringByReplacingOccurrencesOfString:@"src=\"" withString:imagesURl];
                                // 服务器地址 ；；
//    NSLog(@"---sdf --%@",myArticleDetail.content);
    [array addObject:myArticleDetail];
    
    
}


// 城市热点的  图片 和标题
- (void)requestCiytHotTitleWith:(NSMutableArray *) array andSucceed:(void(^)())success andFailed:(void(^)())failed
{
    [array removeAllObjects];
    NSString * urlString  = [HOST stringByAppendingString:@"/articles/gethots"];
    NSURL * url = [NSURL URLWithString:urlString];
   __unsafe_unretained ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        [self analysisCityHotWithDataString:request.responseString andArray:array];
        success();
    }];
    // 加入队列
    ASINetworkQueue * queue = [CityServer getQueueInstance ];
    [queue addOperation:request];
//    [request startAsynchronous];
    [request  setFailedBlock:^{
        failed();
    }];
    

}


// 解析 城市 热点
- (void)analysisCityHotWithDataString:(NSString *)dataString andArray:(NSMutableArray *)array
{
    NSData  * data  = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray * hotCitys = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    for (NSDictionary * dic  in  hotCitys) {
        CityHot * myCityHot = [[CityHot alloc]init];
        myCityHot.cityHotTitle  = [dic valueForKey:@"title"];
        myCityHot.cityHotID = [dic valueForKey:@"id"];
        myCityHot.imagePath = [dic valueForKey:@"url"];
        if ([myCityHot.imagePath hasPrefix:@"http://"]==NO) {
            myCityHot.imagePath = [HOST stringByAppendingFormat:@"%@",myCityHot.imagePath];
            
        }
//        NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:myCityHot.imagePath]];
//        myCityHot.image = [UIImage imageWithData:imageData];
        
        [array addObject:myCityHot];
        
    }
}
// 更多文章列表信息
-(void)requestarticleListTitleWithArray:(NSMutableArray *)array onSucceed:(void(^)())success onFailed:(void(^)())failed
{
    [array removeAllObjects];
    NSString * urlString = [HOST stringByAppendingString:@"/articles/articles"];
    __unsafe_unretained ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request setCompletionBlock:^{
        [self analysisArticleListTitleWithArray:array andDataString:request.responseString];
        success();
    }];
    
//    // 加入队列
    ASINetworkQueue * queue = [CityServer getQueueInstance ];
    [queue addOperation:request];
//    [request startAsynchronous];
    [request setFailedBlock:^{
        failed();
    }];

    
    
}
// 解析 更多 文章标题信息
-(void)analysisArticleListTitleWithArray:(NSMutableArray *)array andDataString:(NSString *)dataString
{
    NSData * data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray * articlesList =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    for (NSDictionary * dic  in articlesList ) {
        ArticleListTitle * myArticleListTitle = [[ArticleListTitle alloc]init];
        myArticleListTitle.articleId = [dic valueForKey:@"id"];
        myArticleListTitle.articleTitle = [dic valueForKey:@"title"];
        myArticleListTitle.subArtcleTitle = [dic valueForKey:@"subtitle"];
        myArticleListTitle.desp = [dic valueForKey:@"desp"];
        [array addObject:myArticleListTitle];
        
    }
    
    
    
}
@end
