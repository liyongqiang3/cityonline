//
//  VideoRequest.h
//  CityEconomyOnline
//
//  Created by a on 13-11-26.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  "ASIHTTPRequest.h"
@interface VideoRequest : NSObject
{
//    ASIHTTPRequest *  request ; // 发送请求 ；
}

// 请求完成是调用 ；
-(void)setCompletionWithPath:(NSString *)path andType:(Videotype)type andArray:(NSMutableArray *)array andBlock:(void(^)())completion ;
// 请求失败时调用
//-(void)setfaliedWithBlock:(void(^)())fail ;

// 发送请求的成功和失败
-(void)setCompletionWithType:(Videotype)type andArray:(NSMutableArray *)array andSuccess:(void (^)(NSInteger index))completion andFailed:(void(^)(NSString * errer))failed ;
// 请求每个具体城市的视频
-(void)requestCityVideoWithType:(Videotype)type andCityId:(NSString *)cityId andArray:(NSMutableArray *)array onSuccess:(void(^)())success onFailed:(void(^)())failed;

// 更多视频得请求
-(void)requestMoreVideoWithType:(Videotype)type andArray:(NSMutableArray *)array onSuccess:(void(^)())success onFailed:(void(^)())failed ;
// 详细的视频请求
-(void)requestVideoDetailWithIndex:(NSInteger)index andArray:(NSMutableArray *)array onSuccess:(void(^)())success onFailed:(void(^)())failed ;

@end
