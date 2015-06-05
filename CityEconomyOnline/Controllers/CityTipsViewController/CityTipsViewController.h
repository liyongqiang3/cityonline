//
//  CityTipsViewController.h
//  CityEconomyOnline
//
//  Created by Tsoftime on 13-8-15.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityTipsCell.h"
//#import "TableViewController.h"
//#import "CityTableView.h"
#define kCityTipsLeftViewWidth 110.0f

@interface CityTipsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,NextPageDelegate>
{
    UIView *_seperatorView;//左边切换的view
    UIButton *_focusButton;//焦点城市
    UIButton *_secretButton;//秘密锦囊

    UITableView *_tableView;

    BOOL _reloading;//是否在刷新
    
    NSMutableArray *_listArray; //  城市锦囊的数据 
    UIView * secretView ;// 秘密锦囊
    BOOL isSecret ; // 
}

@property (nonatomic,retain) NSArray *receiveArray;

@end
