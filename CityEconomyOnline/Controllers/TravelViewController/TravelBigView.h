//
//  TravelBigView.h
//  CityEconomyOnline
//
//  Created by Tsoftime on 13-8-20.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "ImageModel.h"
#import "HttpImageButton.h"
typedef enum {
    TravelBigViewSlider = 0,
    TravelBigViewTips = 1
} TravelBigViewType;
@class TravelViewController;

@interface TravelBigView : UIView
{
    HttpImageButton * httpImageButton;
    UIImageView *_bgImageView;
    UILabel *_contentLabel;
    TravelBigViewType _myType;
    NSMutableArray * imageModels ; // 图片基本信息的实例
    ImageModel * imageModel ;// 图片信息 
    NSTimer * myTimer ; // 定时器
    NSInteger index ;// 切换图片用的
    MBProgressHUD * hud ;
    
}

- (id)initWithFrame:(CGRect)frame withType:(TravelBigViewType)type;

@property (assign,nonatomic) UIViewController * traverViewController ;

- (void)setContentWithData:(NSDictionary *)dicData;
@property(nonatomic,retain) UIButton *_imageButton;
@property(nonatomic,retain) UILabel *_contentLabel;
// 设置图片的 基本信息 三张图片的那种 
-(void)setImageModelArray:(NSMutableArray * )_imageModels ;
//  切换图片
-(void)changeImage;
- (void)setImageModel:(ImageModel *)_imageModel ;


@end
