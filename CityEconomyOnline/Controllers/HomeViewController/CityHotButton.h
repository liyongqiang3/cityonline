//
//  CityHotButton.h
//  CityEconomyOnline
//
//  Created by a on 13-12-2.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityHot.h"
#import "HomeViewController.h"
#import "HttpImageButton.h"
@interface CityHotButton : UIView
{
    HttpImageButton * httpImageButton ;// 图片 按钮
    
    CityHot * cityHot ; // 热点城市
    
    
//
    
}
// 设置 基本 信息  
-(void)setCityHot:(CityHot *)_cityHot;
// 所在的viewcontroller

@property (assign,nonatomic) HomeViewController * viewController ;  // 所在的viewController




@end
