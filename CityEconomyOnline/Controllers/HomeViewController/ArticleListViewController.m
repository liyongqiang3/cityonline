//
//  ArticleListViewController.m
//  CityEconomyOnline
//
//  Created by a on 13-12-6.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "ArticleListViewController.h"
#import "ArticleListCell.h"
#import "ArticleRequest.h"
#import "ArticleListTitle.h"
#import "FocusDetailViewController.h"
@interface ArticleListViewController ()

@end

@implementation ArticleListViewController
@synthesize listTalbeView = _listTalbeView ;
@synthesize leftString = _leftString ;

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
    UITabBar *navTabBar = [[UITabBar alloc]initWithFrame:CGRectMake(0, 0, 1024, 44)];
    [navTabBar setBackgroundImage:[UIImage imageNamed:@"SecondNavBar_Bg"]];
    [self.view addSubview:navTabBar];
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 5, 45, 40)];
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 11, 10, 11);
    [leftBtn setImage:[UIImage imageNamed:@"back_01.png"] forState:UIControlStateNormal]; // 回到上一级
    
    
    [leftBtn addTarget:self action:@selector(backHome) forControlEvents:UIControlEventTouchUpInside];
    
    [navTabBar addSubview:leftBtn];
    
    _leftMenuView = [[UIView alloc] initWithFrame:CGRectMake(0, 46, kLeftViewWidth, height(self.view)-46)];
    _leftMenuView.backgroundColor = RGBCOLOR(51, 50, 50);
//    _leftMenuView.backgroundColor = RGBCOLOR(51, 50, 50);
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(420, 0,200 , 50)];
    label.backgroundColor = RGBCOLOR(51, 50, 50);
    label.text = _leftString;
    label.textColor = RGBCOLOR(255 , 255, 255);
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
//    [_leftMenuView addSubview:label];
//    [self.view addSubview:_leftMenuView];
    [navTabBar addSubview:label];
    
    
    
    _listTalbeView = [[UITableView alloc] initWithFrame:CGRectMake(0,44,1024,768-45)];
    _listTalbeView.delegate = self;
    _listTalbeView.dataSource = self;
//    _listTalbeView.backgroundColor = [UIColor clearColor];
    _listTalbeView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ListBackGround.png"]];
    _listTalbeView.separatorColor = RGBCOLOR(45, 45, 45);
    [self.view addSubview:_listTalbeView];
    self->contentArray = [[NSMutableArray alloc]init];
    
    hud = [[MBProgressHUD alloc]init];
    hud.labelText = @"loading......";
    [self.view addSubview:hud];
    [hud show:YES];
    [self httpGetData];


    
    
}
-(void)backHome
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
// 获取网络数据
-(void)httpGetData
{
    ArticleRequest * request = [[ArticleRequest alloc]init];
    [request requestarticleListTitleWithArray:contentArray onSucceed:^{
        
        [_listTalbeView reloadData];
        [hud hide:YES];
    } onFailed:^{
        
        [hud hide:YES];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
 
}
#pragma  UItableView DataSure mothods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [contentArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     static  NSString * indentifier = @"ArticleListCell";
    ArticleListCell * cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[ArticleListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        
    }
    [cell setArticleListTitle:[contentArray objectAtIndex:indexPath.row]];
    
     return cell ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  144 ;
}
// 选择具体的某一行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //自定义 动画效果
    CATransition * transition =  [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = UIViewAnimationCurveEaseInOut;
    transition.type = kCATransitionPush ;
    transition.subtype = kCATransitionFromBottom ;
    transition.startProgress = 0.0 ;
    transition.endProgress = 1.0 ;
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transition forKey:@"animation"];
    
    
    ArticleListTitle * articleListTitle = [ contentArray objectAtIndex:indexPath.row];
    FocusDetailViewController * myFocusDetailViewController = [[FocusDetailViewController alloc]initWithDetailID:articleListTitle.articleId];
    myFocusDetailViewController.viewController = self ;
    
//    myFocusDetailViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal ;
    [self presentViewController:myFocusDetailViewController animated:NO  completion:nil];
}
@end
