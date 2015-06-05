//
//  CityServer.h
//  CityEconomyOnline
//
//  Created by a on 13-12-1.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityServer : NSObject
{
    //
}
// 得到一个单实例
+(CityServer *)getInstance ;

//初始化一些数据
-(void)initServer ;
// 进入后台时候
- (void)serverEnterBackground ;

// 退出程序
-(void)serverExitProgram;


// 得到一个队列
+(id)getQueueInstance;


@end
