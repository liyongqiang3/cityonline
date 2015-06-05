//
//  MyRootViewController.h
//  CityEconomyOnline
//
//  Created by Tsoftime on 13-8-14.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "TravelViewController.h"
#import "MicroCityViewController.h"
#import "CityTipsViewController.h"

@interface MyRootViewController : UIViewController
{
    UIView *_leftMenuView;//左边的按钮的容器
    UIButton *_homeButton;//首页按钮
    UIButton *_travelButton;//城市旅游按钮
    UIButton *_talkButton;//对话城市
    UIButton *_microCityButton;//微城市
    UIButton *_cityTipsButton;//城市锦囊
    
    HomeViewController *_homeViewController;
    TravelViewController *_travelViewController;
    MicroCityViewController *_talkCityViewController;
    MicroCityViewController *_microViewController;
    CityTipsViewController *_cityTipsViewController;
    UIImageView * headImageView ;   //  显示字体
    
    NSString *navTitle;
}

@end
