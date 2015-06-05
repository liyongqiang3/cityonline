//
//  TalkMicroView.h
//  CityEconomyOnline
//
//  Created by Tsoftime on 13-8-17.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//
/* 对话城市，微城市*/

#import <UIKit/UIKit.h>
#import "NewesVideo.h"
#import "MBProgressHUD.h"
#define kCommonViewWidth 243.0f
#define kCommonViewHeight 207.0f
#import "HttpImageButton.h"
typedef enum {
    TalkCity = 1,
    MicroCity,
    CityTips
}CommonViewType;

@interface CommonView : UIView
{
    HttpImageButton *httpImageButton;// 图片按钮
    UILabel *_label;//图片下面的文字
    NewesVideo * newesVideo ; // 数据信息 ；
    MBProgressHUD * hud ;
    
}
@property (nonatomic,assign) UIViewController * superViewController ;

- (id)initWithFrame:(CGRect)frame withType:(CommonViewType)type;

- (void)setContentWithData:(NSDictionary *)dicData;
-(void)setNewesVideo:(NewesVideo *)_newesViedo ;


@end
