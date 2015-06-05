//
//  CityServer.m
//  CityEconomyOnline
//
//  Created by a on 13-12-1.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "CityServer.h"
#import "ASINetworkQueue.h"
@implementation CityServer

static CityServer * server  = nil ;


static  ASINetworkQueue * queue  = nil ;



// 得到一个单实例
+(CityServer *)getInstance
{
     @synchronized(self)
    {
        if (nil == server) {
            [self new];
            
        }
    
    }
    return server ;
    
}
/*
 * 单实例模式
 */
+(id)allocWithZone:(struct _NSZone *)zone
{
    @synchronized(self)
    {
        if (server == nil) {
            
            server = [super allocWithZone:zone];
            return server ;
        }
    }
    return nil ;
    
}

//初始化一些数据
-(void)initServer
{
   

}
+(id)getQueueInstance
{
    @synchronized(queue)
    {
        if (nil == queue) {
            queue = [[ASINetworkQueue alloc]init];
            
            queue.maxConcurrentOperationCount = 4 ;
            [queue reset];
            [queue go];
            
            
        }
        
    }
    return queue ;
}
 
// 进入后台时候
- (void)serverEnterBackground
{
    
}

// 退出程序
- (void)serverExitProgram
{
    
}
@end
