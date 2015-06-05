//
//  ArticleListViewController.h
//  CityEconomyOnline
//
//  Created by a on 13-12-6.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface ArticleListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_viewList;
    UIView *_leftMenuView;//左边的按钮的容器
    UIView *_seperatorView; // 分割线
//    NSString *leftString; // 左边的 
    NSString *navString;
    MBProgressHUD * hud ;
    NSMutableArray * contentArray ; // 文章数据
    
}
@property (retain,nonatomic) UITableView * listTalbeView ;
@property (retain,nonatomic) NSString * leftString  ;// 分割线

//@property (retain)
@end
