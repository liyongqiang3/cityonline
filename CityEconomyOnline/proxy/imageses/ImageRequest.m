 //
//  ImageRequest.m
//  CityEconomyOnline
//
//  Created by liyongqiang on 13-11-27.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "ImageRequest.h"
#import "ASIHTTPRequest.h"
#import "ImageModel.h"
#import "BigImage.h"
#import "ImagePdf.h"
#import "ASINetworkQueue.h"
#import "CityServer.h"
@implementation ImageRequest
//static  NSOperationQueue * queue = nil ;
///  /pictures/getalllistsbyappearence 图片的路径
// 请求图图集的方法的
-(void)requestImageseWithArray:(NSMutableArray *)array andSucceed:(void(^)())success onFailed:(void(^)())failed
{
   
    NSString * urlString  = [HOST stringByAppendingString:@"/pictures/getalllistsbyappearence"];
    
    NSURL * url = [NSURL URLWithString:urlString];
    
    __unsafe_unretained  ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
    
//        (__block)ImageRequest * Imgresust  = self ;
        [self analysisImageseJSONWithString:request.responseString andArray:array];
        success();
        
    }];
    ASINetworkQueue * queue = [CityServer getQueueInstance ];
//    [queue addOperation:request];
//    [request startAsynchronous];
    [queue addOperation:request];
    [request setFailedBlock:^{
        if (request.error != nil) {
            failed();
        }
        
    }];
    
  
    
    
}
//解析图片 的标题
-(void)analysisImageseJSONWithString:(NSString *)dataString andArray:(NSMutableArray *)array
{
    NSData * data = [dataString dataUsingEncoding:NSUTF8StringEncoding ];
    
    NSArray * listImages = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    for (int i = 0 ; i < [listImages count]; i ++) {
    
        NSArray * Imageses = [listImages objectAtIndex:i];
        NSMutableArray * imageArray = [[NSMutableArray alloc]init];
        for (int j = 0; j < [Imageses count]; j ++) {
            NSDictionary * dic = [Imageses objectAtIndex:j];
            ImageModel * myImageModel = [[ImageModel alloc]init];
            myImageModel.landscape_name = [dic valueForKey:@"landscape_name"];
            myImageModel.landscape_id = [dic valueForKey:@"landscape_id"];
            myImageModel.imageUrl = [dic valueForKey:@"url"];
            myImageModel.cityid = [dic valueForKey:@"cityid"];
            
            if ([myImageModel.imageUrl hasPrefix:@"http://"]==NO) {
                myImageModel.imageUrl  = [HOST stringByAppendingFormat:@"%@",myImageModel.imageUrl];
            }
            
//            NSLog(@"-----$$$$---%@",myImageModel.imageUrl);
//            NSURL * url = [NSURL  URLWithString:myImageModel.imageUrl];
//            NSData * data = [NSData dataWithContentsOfURL:url];
//            myImageModel.image = [UIImage imageWithData:data];
            
            
            [imageArray addObject:myImageModel];
            
        }
        [array addObject:imageArray];
    }
    
}
// 攻略推荐的请求
- (void)requeststrategyimageWith:(NSMutableArray *)array andSucceed:(void(^)())success onFailed:(void(^)())failed
{
    [array removeAllObjects];
    
    NSString * urlString  = [HOST stringByAppendingString:@"/pictures/getbyusage?usage=1"];
    
    
    NSURL * url = [NSURL URLWithString:urlString];
    
    __unsafe_unretained ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        
        [self analysisStrategyImageWithArray:array andDataString:request.responseString];
        success();
    }];
    ASINetworkQueue * queue = [CityServer getQueueInstance ];
    [queue addOperation:request];
//    [request startAsynchronous];
    [request setFailedBlock:^{
        
        failed();
        
    }];
   
    
}

// 解析 攻略推荐 的图集
- (void)analysisStrategyImageWithArray:(NSMutableArray * )array andDataString:(NSString *)dataString
{
    NSData * data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray * imageArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    for (int i = 0 ; i < [imageArray count]; i ++) {
        
        NSDictionary * dic  = [imageArray objectAtIndex:i];
        ImageModel * myImageModel = [[ImageModel alloc]init];
        myImageModel.landscape_name = [dic valueForKey:@"landscape_name"];
        myImageModel.landscape_id = [dic valueForKey:@"landscape_id"];
        myImageModel.imageUrl = [dic valueForKey:@"url"];
        if ([myImageModel.imageUrl hasPrefix:@"http://"]==NO) {
            myImageModel.imageUrl  = [HOST stringByAppendingFormat:@"%@",myImageModel.imageUrl];
        }
//        NSLog(@"-----$$$$---%@",myImageModel.imageUrl);
        
//        NSURL * url = [NSURL  URLWithString:myImageModel.imageUrl];
//        NSData * data = [NSData dataWithContentsOfURL:url];
//        myImageModel.image = [UIImage imageWithData:data];
        [array addObject:myImageModel];
        
    }
    
}
// 请求 所在城市的图集 旅游照片

-(void)requestCiytImageWithArray:(NSMutableArray *)array  andCityId:(NSString *)cityId onSucceed:(void(^)())success  onfailed:(void(^)())failed;
{
    [array removeAllObjects];
    
    NSString * urlString  = [HOST stringByAppendingFormat:@"/pictures/getalllistsbyappearence?city=%@",cityId];
//    NSLog(@"___(((()))______%@",urlString);
    NSURL * url = [NSURL URLWithString:urlString];

    
    __unsafe_unretained ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        
        [self analysisImageseJSONWithString:request.responseString andArray:array];
        success();
    }];
    // 加入队列
    
    ASINetworkQueue * queue = [CityServer getQueueInstance ];
    [queue addOperation:request];
//    [request startAsynchronous];
    [request setFailedBlock:^{
        
        failed();
        
    }];
    

}
-(void)requestCityTipsImageWithArray:(NSMutableArray *)array  onSucceed:(void(^)())success onFailed:(void(^)())failed
{
    
}

// 请求幻灯片的大图片
-(void)requestBigImageWithArray:(NSMutableArray *)array andUsage:(NSInteger )usage andCity:(NSInteger)city andLandscape:(NSInteger )landscape onSucceed:(void(^)())success onFailed:(void(^)())failed
{
    [array removeAllObjects];
    NSString * urlString = [HOST stringByAppendingFormat:@"/pictures/getpicturelist?landscape=%i",landscape];
//    NSLog(@"----%@",urlString);
//    NSString  * urlString = @"http://192.168.51.38:3000/pictures/getpicturelist";
    if (city!=-1) {
        urlString = [urlString stringByAppendingFormat:@"&city=%i",city];
        
    }
    NSURL * url = [NSURL URLWithString:urlString];
    __unsafe_unretained  ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:url];
    
    [request setCompletionBlock:^{
        [self analysisBigImagesWithArray:array andDataString:request.responseString];
        success();
    }];
    [request startAsynchronous];
    [request setFailedBlock:^{
        failed();
    }];
    
//    ASINetworkQueue * queue = [CityServer getQueueInstance ];
//    [queue addOperation:request];
    
}
// 解析 幻灯片的大图片
-(void)analysisBigImagesWithArray:(NSMutableArray *)array andDataString:(NSString *)dataString
{
    NSData * data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray * bigImageArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    for (NSDictionary  * dic in bigImageArray) {
        BigImage * myBigImage = [[BigImage alloc]init];
        myBigImage.imageId = [dic   valueForKey:@"id"];
        myBigImage.imageTitle = [dic valueForKey:@"title"];
        myBigImage.imageUrl = [dic valueForKey:@"url"];
        if ([myBigImage.imageUrl hasPrefix:@"http://"] == NO) {
            myBigImage.imageUrl = [HOST stringByAppendingString:myBigImage.imageUrl];
        }
        [array addObject:myBigImage];
        
    }
}

// 获的ptf 的请求
-(void)requestImagePdfWithArray:(NSMutableArray *)array andCityId:(NSInteger )cityId onSuccess:(void(^)())success onFailed:(void(^)())failed
{
    [array removeAllObjects];
    NSString * urlString  = [HOST stringByAppendingString:@"/secrettips/getallpdf"];
    NSURL * url = [NSURL URLWithString:urlString];
    __unsafe_unretained  ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        [self analysisImagePdfWithArray:array andDataString:request.responseString];
        success();
        
    }];
    ASINetworkQueue * queue = [CityServer getQueueInstance ];
    [queue addOperation:request];
//    [request startAsynchronous];
    [request setFailedBlock:^{
        failed();
    }];
    
    
}
// 解析 pdf
-(void)analysisImagePdfWithArray:(NSMutableArray *)array andDataString:(NSString *)dataString
{
    NSData * data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSArray  * pdfArray  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    for (NSDictionary * dic in pdfArray) {
        ImagePdf * myImagePdf = [[ImagePdf alloc]init];
        myImagePdf.pdfId = [dic valueForKey:@"id"];
        myImagePdf.pdfName = [dic valueForKey:@"name"];
        
        myImagePdf.pdfUrl = [dic valueForKey:@"purl"];
        if ([myImagePdf.pdfUrl hasPrefix:@"http://"] == NO) {
            myImagePdf.pdfUrl =  [HOST stringByAppendingString:myImagePdf.pdfUrl];
        }
        myImagePdf.iamgeUrl = [dic valueForKey:@"aurl"];
        if ([myImagePdf.iamgeUrl hasPrefix:@"http://"] == NO) {
            myImagePdf.iamgeUrl = [HOST stringByAppendingString:myImagePdf.iamgeUrl];
        }
//        NSLog(@"%@",myImagePdf.pdfUrl);
//        NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:myImagePdf.iamgeUrl]];
//        myImagePdf.image = [UIImage imageWithData:imageData];
        
        
        [array addObject:myImagePdf];
        
    }

    
}
@end
