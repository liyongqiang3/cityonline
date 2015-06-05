//
//  CityNetQueue.m
//  CityEconomyOnline
//
//  Created by a on 14-1-25.
//  Copyright (c) 2014年 TSoftime. All rights reserved.
//

#import "CityNetQueue.h"
#import "ASINetworkQueue.h"

@implementation CityNetQueue
{
    ASINetworkQueue *queue;
}

static CityNetQueue * instance;


+ (CityNetQueue *) instance
{
    @synchronized(self) {
        if (!instance) {
            instance = [[self alloc] init];
            instance->queue = [[ASINetworkQueue alloc] init];
            instance->queue.maxConcurrentOperationCount = 4;
        }
    }
    return instance;
}

+ (id) copyWithZone:(struct _NSZone *)zone{
    return self;
}

+ (id) allocWithZone:(struct _NSZone *)zone{
    @synchronized(self) {
        if (!instance) {
            instance = [self allocWithZone:zone];
            return instance;
        }
    }
    return nil;
}
@end
