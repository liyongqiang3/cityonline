//
//  MicroCityViewController.h
//  CityEconomyOnline
//
//  Created by Tsoftime on 13-8-15.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//
/* 对话城市，微城市 */

#import <UIKit/UIKit.h>
#import "CommonView.h"
#import "ASIHTTPRequest.h"

@interface MicroCityViewController : UIViewController
{
   
    NSMutableArray *  dataArray ; // 存储所有数据；；
    BOOL isPrompt ; // 是否提示过
    BOOL isrequest ;// 是否 请求
    
    NSMutableArray * firstArray ;//第一部分
    NSMutableArray * secondArray ;// 第二部分
    NSMutableArray * thirdArray ;//第三部分
    
    
}
@property (nonatomic) CommonViewType myType;

- (id)initWithType:(CommonViewType)type;


@end
