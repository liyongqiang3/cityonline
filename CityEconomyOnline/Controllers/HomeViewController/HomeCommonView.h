//
//  HomeCommonView.h
//  CityEconomyOnline
//
//  Created by Tsoftime on 13-8-17.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kHomeVideoHeight 180
#define kHomeTipsHeight  117.0f
#import "NewesVideo.h"
#import "MBProgressHUD.h"
#import "HttpImageButton.h"
@class HomeViewController ;
@interface HomeCommonView : UIView
{
    HttpImageButton *httpImageButton;//
    UILabel *_label;
    NewesVideo * newesVideo  ;
    HomeViewController * homeViewController ;
    MBProgressHUD * hud ; // 
}

-(void)setHomeViewController:(HomeViewController *)_homeViewController ;

- (void)setContentWithData:(NSDictionary *)dicData;

-(void)setNewesVideo:(NewesVideo *)_newesVideo ;


@end
