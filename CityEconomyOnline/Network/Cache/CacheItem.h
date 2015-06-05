//
//  CacheItem.h
//  CityEconomyOnline
//
//  Created by 季程跃 on 13-11-2.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CacheItem;
@protocol CacheItemDelegate <NSObject>

//下载成功时执行该方法
-(void)cacheItemDownSucceeded:(CacheItem *)paramSender
                withRemoteURL:(NSURL *)paramRemoteURL
    withAboutTobeReleasedData:(NSData *)paramAboutTobeReleasedData;
//下载失败时执行该方法
-(void)cacheItemDownFailed:(CacheItem *)paramSender
                 remoteURL:(NSURL *)paramRemoteURL
                 withError:(NSError *)paramError;


@end

@interface CacheItem : NSObject{
    @public
        id<CacheItemDelegate> delegate;
        NSString *remoteURL;
    @private
        BOOL isDownLoading;//是否正在下载
        NSMutableData *connData;
        NSURLConnection *conn;
}

@property(nonatomic,assign) id<CacheItemDelegate> delegate;
@property(nonatomic,retain) NSString *remoteURL;
@property(nonatomic,assign) BOOL isDownLoading;
@property(nonatomic,retain) NSMutableData *connData;
@property(nonatomic,retain) NSURLConnection *conn;

-(BOOL)startDownLoading:(NSString *)paramRemoteURL;

@end


