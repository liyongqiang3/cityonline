//
//  PowerpointViewController.h
//  Powerpoint
//
//  Created by a on 13-12-9.
//  Copyright (c) 2013年 liyongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "ImageModel.h"
#import "BigImage.h"
@interface PowerpointViewController : UIViewController<UIScrollViewDelegate>
{
    NSMutableArray * imageArray ;// 图片 数据
    NSTimer * myTimer ;// 定时器
    NSInteger  onceTime;// 播放时间
    
    MBProgressHUD * hud ;// 网络加载提示
    NSArray * timerArray;
    ImageModel * imageModel ;// 图片的对象
    NSMutableArray * bigImages; // 图像数组
    NSInteger timerIndex ;
    NSMutableArray  * myImageViews ;
    UITapGestureRecognizer  * tapGesture ;//
    MBProgressHUD * hud1 ;//幻灯片提示
    
    BOOL isShowNavgation ; // 显示导航
    
    UITabBar *navTabBar ;
    
    UILabel * titleLable ; // 信息标题
    
    
}
-(void)setImageArray:(NSMutableArray *)_imageArray ;
@property (retain,nonatomic) UIScrollView *  listScrollView ; //存放图片大地方

@property (retain,nonatomic) UIButton * showButton   ; // 放映按钮

@property (retain,nonatomic) UIButton * addButton ;   // 添加按钮

@property (assign,nonatomic) NSInteger    index ;
//@property (retain,nonatomic) UIButton * locationButton ;// 定位按钮

@property (assign,nonatomic) NSInteger type ;

@property (assign,nonatomic) UIViewController * viewController ;


// 初始化 图像 ；
-(id)initWithImageModel:(ImageModel *)_imageModel ;

//@property (retain,nonatomic)
@end
