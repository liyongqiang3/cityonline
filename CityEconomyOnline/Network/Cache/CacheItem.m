//
//  CacheItem.m
//  CityEconomyOnline
//
//  Created by 季程跃 on 13-11-2.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "CacheItem.h"

@implementation CacheItem
@synthesize delegate;
@synthesize remoteURL;
@synthesize isDownLoading;
@synthesize conn;
@synthesize connData;

-(BOOL)startDownLoading:(NSString *)paramRemoteURL
{
    
    return NO;
}

@end
