//
//  SecretTipsViewController.h
//  CityEconomyOnline
//
//  Created by a on 13-12-3.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CityTipsCell.h"
#import "MBProgressHUD.h"
@interface SecretTipsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    NSMutableArray * cityTips  ;// pdf 对象的数据
    
    CGRect  viewFrame ;
    MBProgressHUD * hud ; // 进度条
    BOOL isGethttp;
    MBProgressHUD * hud3 ;
 
    
    
}

@property  (retain,nonatomic) UITableView * cityTabeleView ;

-(id)initWithFrame:(CGRect)frame;

@end
