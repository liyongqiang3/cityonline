//
//  TimerViewController.h
//  CityEconomyOnline
//
//  Created by a on 13-12-10.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kSettingsWidth  270.0f
#define kSettingsHeight 256.0f
@interface TimerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    UITableView * timerTableView ;// 选择时间的 tableView
    NSArray * timerArray ;// 时间数据
    NSInteger  selected ;//选中的行数
    
    
}

@end
