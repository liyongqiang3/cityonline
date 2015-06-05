//
//  TravelViewController.h
//  CityEconomyOnline
//
//  Created by Tsoftime on 13-8-15.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TravelBigView.h"
#import "TravelSmallView.h"
#import "SettingsViewController.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"


@interface TravelViewController : UIViewController
{
    //左边的四个标题标签
    UILabel *_titleLabel1;
    UILabel *_titleLabel2;
    UILabel *_titleLabel3;
    UILabel *_titleLabel4;

    //两个更多按钮
    UIButton *_videoMoreButton;
    UIButton *_tipsMoreButton;
    
    //收藏城市和设置两个按钮
    UIButton *_myCityButton;
    UIButton *_settingsButton;
    
    //第二部分和第四部分的两个容器
    UIView *_secondContainerView;
    UIView *_forthContrainerView;
    
    //第一部分的两个不动的图片
    TravelBigView *_firstPhoto;
    TravelBigView *_secondPhoto;
    TravelBigView *_thirdPhoto;
    NSMutableArray * travelbigs ;
    
    
    TravelBigView *tipsView0;
    TravelBigView *tipsView1;
    TravelBigView *tipsView2;
    
    UIButton *_secondButton;//399
    UIImageView *_secondBgImageView;
    UILabel *_secondLabel;
    
    ASINetworkQueue *networkQueue;
    ASIHTTPRequest *request;
    ASIHTTPRequest *request2;
    
    NSMutableArray *imgArray;
    
    NSTimer *_timer;//第一部分的第二个图片的变换timer
    
    UIPopoverController *_settingPopoverController;
    SettingsViewController *_settingViewController;
    
    
     // 存放图片基本信息的数据
    NSMutableArray  * imageArray ;
    
    NSMutableArray * smallViewDataArray ; //小视频的数据
    
    NSMutableArray * strategyDataArray ; // 攻略 推荐 的数据
    
    BOOL isPrompt ;// 提示 网络 是否 加载成功
    
    int index;
    BOOL islaod ;// 是否加载过
    
}

@property (nonatomic,retain) NSArray *timerDataArray;

@end
