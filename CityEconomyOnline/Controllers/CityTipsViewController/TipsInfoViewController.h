//
//  TipsInfoViewController.h
//  CityEconomyOnline
//
//  Created by 季程跃 on 13-11-7.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TipInfoView.h"
#import "SettingsViewController.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"

@interface TipsInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIView *_leftMenuView;//左边的按钮的容器
    
    //左边的四个标题标签
    UILabel *_titleLabel1;
    UILabel *_titleLabel2;
    UILabel *_titleLabel3;
    UILabel *_titleLabel4;
    
    ASINetworkQueue *networkQueue;
    ASIHTTPRequest *request;
    
    
    
    //第四部分图片
    UIImageView *_imageView;

    
    //两个更多按钮
    UIButton *_videoMoreButton;
    UIButton *_tipsMoreButton;
    
    //收藏城市和设置两个按钮
    UIButton *_myCityButton;
    UIButton *_settingsButton;
    
    //第二部分和第四部分的两个容器
    UIView *_secondContainerView;
    UIView *_forthContrainerView;
    UIView *_rightView;
    
    //第一部分的两个不动的图片
    TipInfoView *_firstPhoto;
    TipInfoView *_secondPhoto;
    TipInfoView *_thirdPhoto;
    NSMutableArray * travelbigs ;
    UIButton *_secondButton;//399
    UIImageView *_secondBgImageView;
    UILabel *_secondLabel;
    
    UIPopoverController *_settingPopoverController;
    SettingsViewController *_settingViewController;
    
    NSTimer *_timer;
    NSMutableArray *imgArray; // 第一部分存放图片的地方
//    NSArray *array;//
    
    UIImageView * cityImageView ;//城市 图标
    NSMutableArray * travelVideos ;
    
    UITableView *tvList;
    BOOL isHttpData ; // 网络请求是否成功
       BOOL isPrompt ; // 是否提示 ；

}
@property (nonatomic,retain) NSArray *array; //
@property (nonatomic,retain) NSArray *timerDataArray; //
@property (nonatomic,retain) NSMutableArray *tvName; // 
@end
