//
//  SettingsViewController.m
//  CityEconomyOnline
//
//  Created by Tsoftime on 13-8-21.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//
#import "TimerViewController.h"
#import "SettingsViewController.h"
#import "UMSocial.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSettingsWidth, kSettingsHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
-(void)viewWillAppear:(BOOL)animated
{
       self.contentSizeForViewInPopover = CGSizeMake(kSettingsWidth, kSettingsHeight);
        selected  = [[NSUserDefaults standardUserDefaults]integerForKey:kDefaultSliderTime];
    [_tableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 1;
    switch (section) {
        case 0:
            rows = 1;
            break;
        case 1:
            rows = 2;
            break;
        case 2:
            rows = 1;
            break;
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"SectionCell0";
    switch (indexPath.section) {
        case 0:
            identifer = @"SectionCell0";
            break;
        case 1:
            identifer = @"SectionCell1";
            break;
        case 2:
            identifer = @"SectionCell0";
            break;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        if (indexPath.section == 0) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else{
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    switch (indexPath.section) {
            
        case 0:{
            cell.textLabel.text = @"单幅放映时间";

            NSArray  *  timerArray = @[@"2秒",@"3秒",@"5秒",@"10秒",@"15秒",@"30秒",@"1分钟"];
            NSString * timeStr = [timerArray objectAtIndex:selected];
            
            cell.detailTextLabel.text = timeStr;
        }
            break;
        case 1:
            if (indexPath.row == 0) {
                cell.textLabel.text = @"告诉您的朋友";
            }
            else{
                cell.textLabel.text = @"联系我们";
            }
            break;
        case 2:
            cell.textLabel.text = @"帮助";
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:{
//            [[CommonUtils sharedUtils] alertWithMessage:@"请耐心等待!"];
            TimerViewController * mytimerview = [[TimerViewController alloc]init];
        
            [self.navigationController pushViewController:mytimerview animated:YES];
        }
            break;
        case 1:
            if (indexPath.row == 0) {
                
//                [[CommonUtils sharedUtils] alertWithMessage:@"分享功能暂无开放，请耐心等待!"];
                               
                [UMSocialSnsService presentSnsController:self appKey:@"507fcab25270157b37000010" shareText:@"分享内容测试实例ipad！" shareImage:nil shareToSnsNames:@[UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToFacebook] delegate:nil ];
            }
            else{
//               [[CommonUtils sharedUtils] alertWithMessage:@"亲，此功能暂无开放哦!"];
            }
            break;
        case 2:
//            [[CommonUtils sharedUtils] alertWithMessage:@"亲，此功能暂无开放哦！"];
            break;
    }
}

@end
