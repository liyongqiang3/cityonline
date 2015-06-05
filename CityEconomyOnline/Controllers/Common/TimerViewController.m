//
//  TimerViewController.m
//  CityEconomyOnline
//
//  Created by a on 13-12-10.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()

@end

@implementation TimerViewController

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
    [self.view setFrame:CGRectMake(0, 0, kSettingsWidth, kSettingsHeight)];
    timerTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,kSettingsWidth, kSettingsHeight  ) style:UITableViewStylePlain];
    timerTableView.dataSource = self ;
    timerTableView.delegate = self ;
    timerTableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
    [self.view addSubview:timerTableView];
    timerArray = @[@"2秒",@"3秒",@"5秒",@"10秒",@"15秒",@"30秒",@"1分钟"];
    self->selected = [[NSUserDefaults standardUserDefaults] integerForKey:kDefaultSliderTime];
    

}
-(void)viewWillAppear:(BOOL)animated
{
      self.contentSizeForViewInPopover = CGSizeMake(kSettingsWidth, kSettingsHeight);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma UITableView DataSoure methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  7;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identiferCell = @"indentiferCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identiferCell ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identiferCell];
               if (selected==indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark ;

        }
    }
    cell.textLabel.text = [ timerArray objectAtIndex:indexPath.row];
    return cell ;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSUserDefaults standardUserDefaults]setInteger:indexPath.row forKey:kDefaultSliderTime];
    NSLog(@"————————＝%i",indexPath.row);
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return   44.5 ;
//}
@end
