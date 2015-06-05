//
//  ImageRequest.h
//  CityEconomyOnline
//
//  Created by a on 13-11-27.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageRequest : NSObject

// 请求图图集的方法的
-(void)requestImageseWithArray:(NSMutableArray *)array andSucceed:(void(^)())success onFailed:(void(^)())failed;

// 攻略推荐的里面的图片
- (void)requeststrategyimageWith:(NSMutableArray *)array andSucceed:(void(^)())success onFailed:(void(^)())failed ;

// 请求 所在城市的图集
-(void)requestCiytImageWithArray:(NSMutableArray *)array  andCityId:(NSString *)cityId onSucceed:(void(^)())success  onfailed:(void(^)())failed;

// 锦囊推荐得图片
-(void)requestCityTipsImageWithArray:(NSMutableArray *)array  onSucceed:(void(^)())success onFailed:(void(^)())failed ;
// 请求幻灯片的大图片
-(void)requestBigImageWithArray:(NSMutableArray *)array andUsage:(NSInteger )usage andCity:(NSInteger)city andLandscape:(NSInteger )landscape onSucceed:(void(^)())success onFailed:(void(^)())failed ;

// 获的ptf 的请求
-(void)requestImagePdfWithArray:(NSMutableArray *)array andCityId:(NSInteger )cityId onSuccess:(void(^)())success onFailed:(void(^)())failed;

@end
