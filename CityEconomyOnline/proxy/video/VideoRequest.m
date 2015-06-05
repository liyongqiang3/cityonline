//
//  VideoRequest.m
//  CityEconomyOnline
//
//  Created by a on 13-11-26.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "VideoRequest.h"
#import "NewesVideo.h"
#import "MoreVideo.h"
#import "VideoDetail.h"
#import "ASINetworkQueue.h"
#import "CityServer.h"
@implementation VideoRequest

-(void)setCompletionWithPath:(NSString *)path andType:(Videotype)type andArray:(NSMutableArray *)array andBlock:(void(^)())completion
{
    //http://192.168.51.38:3000/videos/getbyusage/?usage=1
    
    // 组装url字符串 ；
    array = [[NSMutableArray alloc]init];
    NSString * urlString = [HOST stringByAppendingFormat:@"%@usage=%i",path,type];
    
    NSURL * url = [NSURL URLWithString:urlString];
//    NSLog(@"%@",url);
    __unsafe_unretained ASIHTTPRequest *  request = [ASIHTTPRequest requestWithURL:url ];

     [request setCompletionBlock:^{
         
         
         [self analysisJSONWithString:request.responseString andArray:array];
         
         completion();
     }];
     [request startAsynchronous];
    
    
//    ASINetworkQueue * queue = [CityServer getQueueInstance ];
//    [queue addOperation:request];
}
-(void)analysisJSONWithString:(NSString *)dataString andArray:(NSMutableArray *)array
{
//    NSLog(@"－－－－－%@",dataString);
    NSData * data =  [dataString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray  *videos  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//    NewesVideo * video = [NewesVide
    for (NSDictionary * dic  in  videos ) {
        NewesVideo * myNewesVideo = [[NewesVideo alloc]init];
        myNewesVideo.newesId  = [dic valueForKey:@"id"];
//        myNewesVideo.newesId = newesId
        myNewesVideo.title = [dic valueForKey:@"title"];
        myNewesVideo.moveUrl = [dic valueForKey:@"url"];
        myNewesVideo.imagePath = [dic valueForKey:@"picturepath"];
        if([myNewesVideo.imagePath hasPrefix:@"http://"]==NO){
            myNewesVideo.imagePath = [HOST stringByAppendingFormat:@"%@",myNewesVideo.imagePath];
        }
        
//        NSLog(@"___88888___%@",myNewesVideo.imagePath);
//        NSURL * url = [NSURL URLWithString:myNewesVideo.imagePath];
////        NSData * data = [NSData dataWithContentsOfURL:url];
//        NSData * imageData = [NSData dataWithContentsOfURL:url];
//        
//        myNewesVideo.image = [UIImage imageWithData:imageData];
        [array addObject:myNewesVideo];
        
    }
    
    
    
}
// 发送请求的成功和失败
-(void)setCompletionWithType:(Videotype)type andArray:(NSMutableArray *)array andSuccess:(void (^)(NSInteger index))completion andFailed:(void(^)(NSString * errer))failed
{
    NSString * urlString = [HOST stringByAppendingFormat:@"/videos/getbyusage/?usage=%i",type];
    
    NSURL * url = [NSURL URLWithString:urlString];
//    NSLog(@"%@",url);
     __unsafe_unretained  ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:url ];
    [array removeAllObjects];
    
    [request setCompletionBlock:^{
        
        [self analysisJSONWithString:request.responseString andArray:array];
               completion(type);
    }];
    ASINetworkQueue * queue = [CityServer getQueueInstance];
   
//    queue.maxConcurrentOperationCount = 1 ;
//    
//    [queue reset];
//    [queue go];
    
//    [request startAsynchronous];
    [request setFailedBlock:^{
        if ([request error] != nil) {
            failed(request.responseString);
            
        }
       
    }];
   [queue addOperation:request];

}

// 请求每个具体城市的视频
-(void)requestCityVideoWithType:(Videotype)type andCityId:(NSString *)cityId andArray:(NSMutableArray *)array onSuccess:(void(^)())success onFailed:(void(^)())failed
{
    
    [array removeAllObjects];
    NSString * urlString = [HOST stringByAppendingFormat:@"/videos/getbyusage/?usage=%i&city=%@",type,cityId];
    
    NSURL * url = [NSURL URLWithString:urlString];
//    NSLog(@"%@",url);
    __unsafe_unretained  ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:url ];
    [array removeAllObjects];
    [request setCompletionBlock:^{
        
        [self analysisJSONWithString:request.responseString andArray:array];
        success();
    }];
//    ASINetworkQueue * queue = [CityServer getQueueInstance ];
//    [queue addOperation:request];
    [request startAsynchronous];
    [request setFailedBlock:^{
        if ([request error] != nil) {
            failed(request.responseString);
            
        }
        
    }];
  

}
// 更多视频得请求
-(void)requestMoreVideoWithType:(Videotype)type andArray:(NSMutableArray *)array onSuccess:(void(^)())success onFailed:(void(^)())failed
{
    NSString * urlString = [HOST stringByAppendingFormat:@"/videos/getlistbyusage/?usage=%i",type];
    NSURL * url = [NSURL URLWithString:urlString];
//    NSLog(@"%@",url);
    __unsafe_unretained  ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:url ];
    [array removeAllObjects];
    [request setCompletionBlock:^{
        [self analysisMoreVideoJSONWithString:request.responseString andArray:array];
        success();
    }];
    [request startAsynchronous];
    [request setFailedBlock:^{
        failed();
    }];
    
    
//    ASINetworkQueue * queue = [CityServer getQueueInstance ];
//    [queue addOperation:request];
}
// 解析更多视频
-(void)analysisMoreVideoJSONWithString:(NSString *)dataString andArray:(NSMutableArray *)array
{
    NSData * data =  [dataString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray  *MoreVideos  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    for (NSDictionary * dic  in MoreVideos) {
        MoreVideo * myMoreVideo = [[MoreVideo alloc]init];
        myMoreVideo.videoId = [dic valueForKey:@"id"];
        myMoreVideo.videoTitle = [dic valueForKey:@"title"];
        myMoreVideo.filepath = [dic valueForKey:@"filepath"];
        myMoreVideo.picturepath = [dic valueForKey:@"picturepath"];
        myMoreVideo.desp = [dic valueForKey:@"desp"];
        myMoreVideo.subtitle = [dic valueForKey: @"subtitle"];
        if (myMoreVideo.picturepath != nil ) {
            if([myMoreVideo.picturepath hasPrefix:@"http://"]==NO){
                myMoreVideo.picturepath = [HOST stringByAppendingFormat:@"%@",myMoreVideo.picturepath];
            }
            NSURL * url = [NSURL URLWithString:myMoreVideo.picturepath];
            NSData * data = [NSData dataWithContentsOfURL:url];
            myMoreVideo.image = [UIImage imageWithData:data];
        }
       
        
//        NSLog(@"___88888___%@",myMoreVideo.picturepath);
//        NSURL * url = [NSURL URLWithString:myMoreVideo.picturepath];
//        NSData * data = [NSData dataWithContentsOfURL:url];
//        myMoreVideo.image = [UIImage imageWithData:data];
        myMoreVideo.usagetype = [dic valueForKey:@"usagetype"];
        myMoreVideo.cityId = [dic valueForKey:@"cities_id"];
        [array addObject:myMoreVideo];
    }
}


// 详细的视频请求
-(void)requestVideoDetailWithIndex:(NSInteger)index andArray:(NSMutableArray *)array onSuccess:(void(^)())success onFailed:(void(^)())failed
{
    // http://192.168.51.38:3000/videos/getdetail/?id=30
    
    NSString * urlString = [HOST stringByAppendingFormat:@"/videos/getdetail/?id=%i",index];
    __unsafe_unretained  ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request  setCompletionBlock:^{
        [self analysisVidoeDetailWithArray:array andDataString:request.responseString];
        success();
    }];
    [request startAsynchronous];
    
    
    [request setFailedBlock:^{
        failed();
        
    }];
    
//    ASINetworkQueue * queue = [CityServer getQueueInstance ];
//    [queue addOperation:request];
}
// 解析视频的详细
-(void)analysisVidoeDetailWithArray:(NSMutableArray *)array andDataString:(NSString *)dataString
{
//    NSLog(@"___%@",dataString);
    NSData * data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
      NSDictionary * dic  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    VideoDetail * myVideoDetail = [[VideoDetail alloc]init];
    myVideoDetail.cityId  = [dic valueForKey:@"id"];
    myVideoDetail.title = [dic valueForKey:@"title"];
    myVideoDetail.filePath = [dic valueForKey:@"filepath"];
    myVideoDetail.picturepath = [dic valueForKey:@"picturepath"];
    myVideoDetail.createDate = [dic valueForKey:@"created_at"];
    myVideoDetail.update = [dic valueForKey:@"updated_at"];
    myVideoDetail.usagetype = [dic valueForKey:@"usagetype"];
    myVideoDetail.desp = [dic valueForKey:@"desp"];
    myVideoDetail.subtiltle = [dic valueForKey:@"subtitle"];
    [array addObject:myVideoDetail];
    
    
    
}
@end
