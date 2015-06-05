//
//  SettingsViewController.h
//  CityEconomyOnline
//
//  Created by Tsoftime on 13-8-21.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSettingsWidth  270.0f
#define kSettingsHeight 256.0f

@interface SettingsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSInteger selected ;
    
}

@end
