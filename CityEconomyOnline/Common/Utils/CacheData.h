//
//  CacheData.h
//  CityEconomyOnline
//
//  Created by a on 13-12-5.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheData : NSObject
// 读出文件
+ (NSMutableArray *)readCacheMemory:(NSString *)valueString ;

// 写入文件
+ (void)writeCacheMemory:(NSMutableArray *)dataArray andKeyString:(NSString *)keyString ;


@end
