//
//  HomeViewController.h
//  CityEconomyOnline
//
//  Created by Tsoftime on 13-8-15.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeCommonView.h"
#import "VideoRequest.h"
@interface HomeViewController : UIViewController<UIScrollViewDelegate>
{
    //第一个模块
    UILabel *_titleLabel1;
    UIScrollView *_hotScrollView;
    UIPageControl *_pageControl;
    UILabel *_imageContentLabel;
    UIImageView *_bgImageView;//城市热点的浅灰色背景
    NSMutableArray * imageButtonarray; // 第一部分的数据 
    UIView *_seperatorView;//一二模块中间的分界线
    
    //第二模块
    UIView *_secondView;//第二部分的容器
    UILabel *_titleLabel2;
    UIButton *_videoMoreButton;//更多按钮
    
    //第三模块
    UIView *_thirdView;
    UILabel *_titleLabel3;
    UIButton *_focusMoreButton;//城市焦点更多
   
    //第四个模块
    UIView *_forthView;
    UILabel *_titleLabel4;
    UIButton *_tipsMoreButton;
    
    NSString *navString;
    
    
    NSTimer * rollTimer ; // 自动滚动幻灯片的
    NSInteger  pageindex ; //
    
    NSMutableArray * firstArray ; // 第一部分的数据 ；
    NSMutableArray * secondArray ; // 第二部分的数据；
    NSMutableArray * thirdArray  ; // 第三部分数据
    NSMutableArray * fourthArray ; // 第四部分的数据 ；
    
    BOOL isPrompt ; // 是否提示 ；
    BOOL isGethttpData; // 是否加载数据
    
}
@property(nonatomic,strong) NSString *navString;

- (id)initWithFrame:(CGRect)frame;

@end
