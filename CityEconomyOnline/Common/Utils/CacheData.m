//
//  CacheData.m
//  CityEconomyOnline
//
//  Created by a on 13-12-5.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "CacheData.h"

@implementation CacheData

// 读出一个 缓存内存 结构
+ (NSMutableArray *)readCacheMemory:(NSString *)valueString
{
    
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    cachePath = [cachePath stringByAppendingFormat:@"/%@.archiver",valueString];
    NSLog(@"-----%@",cachePath);
    
    NSData * thedata = [NSData dataWithContentsOfFile:cachePath];
    NSKeyedUnarchiver * unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:thedata];
    NSMutableArray * array = [ unarchiver decodeObjectForKey:valueString];
    [unarchiver finishDecoding];
    return array ;
    
    
}

//写入文件
+ (void)writeCacheMemory:(NSMutableArray *)dataArray andKeyString:(NSString *)keyString 
{
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    cachePath = [cachePath stringByAppendingFormat:@"/%@.archiver",keyString];
     NSLog(@"-----34345--%@",cachePath);
    NSMutableData * thedata = [[NSMutableData alloc]init];
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:thedata];
    [archiver encodeObject:dataArray forKey:keyString];
    [archiver finishEncoding];
    [thedata writeToFile:cachePath atomically:YES];
    
}
@end
