//
//  SecondaryPageController.m
//  CityEconomyOnline
//
//  Created by 季程跃 on 13-10-4.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "SecondaryPageController.h"
#import "DetailPageCotrollerViewController.h"
#import "ListCell.h"
#import "VideoRequest.h"
#import "MoreVideo.h"
#import "DetailVideoViewContoller.h"
#import <QuartzCore/QuartzCore.h>
@interface SecondaryPageController ()

@end

@implementation SecondaryPageController
@synthesize leftString;
@synthesize navString;
@synthesize content;
-(id)initWithVideoType:(Videotype)type
{
    self = [super init];
    if (self) {
        
        _videoType = type ;
        
    }
    return self ;
}


- (void)viewDidLoad
{
    [super viewDidLoad];//w:1024 h:748 91 44 933 704
    
    UITabBar *navTabBar = [[UITabBar alloc]initWithFrame:CGRectMake(0, 0, 1024, 44)];
    [navTabBar setBackgroundImage:[UIImage imageNamed:@"SecondNavBar_Bg"]];
    [self.view addSubview:navTabBar];
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 5, 45, 40)];
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 11, 10, 11 );
    [leftBtn setImage:[UIImage imageNamed:@"back_01.png"] forState:UIControlStateNormal];
    
    [leftBtn addTarget:self action:@selector(backHome) forControlEvents:UIControlEventTouchUpInside];
    
    [navTabBar addSubview:leftBtn];
    
    _leftMenuView = [[UIView alloc] initWithFrame:CGRectMake(0, 46, kLeftViewWidth, height(self.view)-46)];
    _leftMenuView.backgroundColor = RGBCOLOR(51, 50, 50);
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(450, 0, kLeftViewWidth, 50)];
    label.backgroundColor = [UIColor clearColor];
    label.text = leftString;
    label.textColor = RGBCOLOR(255 , 255, 255);
    label.textAlignment = NSTextAlignmentCenter;
    [navTabBar addSubview:label];
    
//    [_leftMenuView addSubview:label];
//    [self.view addSubview:_leftMenuView];
    self.view.backgroundColor = [UIColor blackColor];
    
//    self.content = [NSMutableArray arrayWithObjects:@"今日新闻",@"明日新闻",@"中国经济是否回春",@"明日新闻",@"中国经济是否回春", nil];
    self.content = [[NSMutableArray alloc]init];
    
    _viewList = [[UITableView alloc] initWithFrame:CGRectMake(0,44,1024,768-45)];
    _viewList.delegate = self;
    _viewList.dataSource = self;
    _viewList.backgroundColor = [UIColor clearColor];
    _viewList.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ListBackGround.png"]];
    _viewList.separatorColor = [UIColor blackColor];
    
//    _viewList.separatorInset
//    _viewList.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched ;
    [self.view addSubview:_viewList];
    _viewList.hidden = YES ;
    //分割线
    _seperatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 1024, 1)];
    _seperatorView.backgroundColor = RGBCOLOR(59, 59, 59);
    [self.view addSubview:_seperatorView];
    hud = [[MBProgressHUD alloc]init];
    [self.view addSubview:hud];
    hud.labelText = @"loading......";
    [hud show:YES];
    
    [self httpGetData];
}
-(void)httpGetData
{
    VideoRequest * request = [[VideoRequest alloc]init];
    [request requestMoreVideoWithType:_videoType andArray:content onSuccess:^{
        _viewList.hidden = NO ;
        if ([content count] == 0) {
            CommonUtils * utils = [[CommonUtils alloc]init];
            [utils alertWithMessage:@"还没有开始传数据！" andView:self.view];
        }
          [_viewList reloadData];
        [hud hide:YES];
    } onFailed:^{
         [hud hide:YES];
        CommonUtils * utils = [[CommonUtils alloc]init];
        [utils alertWithMessage:@"网络有点不给力！" andView:self.view];
        
      
    }];
    
    
}
-(void)backHome
{
//    [self dismissModalViewControllerAnimated:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
   
    return [self.content count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
       cell = [[ListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];

    }
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
    [cell setMoreVideo:[self.content objectAtIndex:indexPath.row]];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    DetailPageCotrollerViewController *detail = [[[DetailPageCotrollerViewController alloc]initWithNibName:@"DetailPageCotrollerViewController" bundle:nil]autorelease];
////    [self presentModalViewController:detail animated:YES];
    CATransition * transition =  [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = UIViewAnimationCurveEaseInOut;
    transition.type = kCATransitionPush ;
    transition.subtype = kCATransitionFromBottom ;
    transition.startProgress = 0.0 ;
    transition.endProgress = 1.0 ;
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transition forKey:@"animation"];
    MoreVideo * myMoreVideo = [ self.content objectAtIndex:indexPath.row];
    DetailVideoViewContoller * detail = [[DetailVideoViewContoller alloc]initWithVideoId:myMoreVideo.videoId];
    detail.viewController = self ;
    
    [self presentViewController:detail animated:NO completion:nil];
    
}


#pragma mark 单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}



@end
