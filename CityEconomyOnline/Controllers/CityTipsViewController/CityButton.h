//
//  CityButton.h
//  CityEconomyOnline
//
//  Created by a on 13-11-28.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecretCityTip.h"
#import "ImagePdf.h"
#import "HttpImageButton.h"
@interface CityButton : UIView
{
    // 城市基本信息的一个实例;
    SecretCityTip * mySecretCityTip ;
    NSTimer * myTimer ;// 一个定时器
    CGFloat proValue ;
    NSMutableArray *  imagepdfArray ;// 存放pdf 的
    ImagePdf * myImagePdf ;  //
       BOOL isLoading ;// 是否正在下载
    
}
@property (assign,nonatomic) UIViewController  * viewController ;
@property (retain,nonatomic) HttpImageButton * httpImageButton ; // 按钮图拍

@property (retain,nonatomic) UILabel * titleLabel ;// 标题 
@property (retain,nonatomic) UIImageView * loadView ; //是否下载的

@property (retain,nonatomic) UIProgressView * progressBar ; // 进度条

// 一个实例方法 加载基本信息 

-(void)setSecretCityTip:(ImagePdf *)imagePdf ;

@end
