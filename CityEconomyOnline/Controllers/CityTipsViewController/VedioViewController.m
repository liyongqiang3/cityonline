//
//  VedioViewController.m
//  CityEconomyOnline
//
//  Created by 季程跃 on 13-11-7.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "VedioViewController.h"

@interface VedioViewController ()

@end

@implementation VedioViewController
@synthesize addressId;
@synthesize tvAddress;


- (void)viewDidLoad
{
    [super viewDidLoad];
    UITabBar *navTabBar = [[UITabBar alloc]initWithFrame:CGRectMake(0, 0, 1024, 44)];
    [navTabBar setBackgroundImage:[UIImage imageNamed:@"SecondNavBar_Bg"]];
 
    //    [self.view addSubview:navTabBar];
    //上面的还回
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(500, 10, 200, 35)];
    titleLabel.text = @"电台直播";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    
    titleLabel.font = [UIFont systemFontOfSize:20];
    [navTabBar addSubview:titleLabel];
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 5, 45, 40)];
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 11, 10, 11) ;
    [leftBtn setImage:[UIImage imageNamed:@"back_01.png"] forState:UIControlStateNormal];
    
    [leftBtn addTarget:self action:@selector(backHome) forControlEvents:UIControlEventTouchUpInside];
    
    [navTabBar addSubview:leftBtn];
    [self.view addSubview:navTabBar];
    tvAddress = [NSMutableArray arrayWithObjects:
                 @"http://live.gslb.letv.com/gslb?stream_id=bjws&tag=live&ext=m3u8&sign=live_ipad",nil];
	
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleLoadStateDidChange:) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(back) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    //NSString *loc =[[NSBundle mainBundle] pathForResource:@"taiji" ofType:@"mp4"];
    
    NSURL *url = [NSURL URLWithString:[tvAddress objectAtIndex:addressId]];
    
    controller = [[MPMoviePlayerController alloc]initWithContentURL:url];
    
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    
    //3.设置我们的View的中心点
    controller.view.center = CGPointMake(frame.origin.x + ceil(frame.size.width/2), frame.origin.y + ceil(frame.size.height/2));
    controller.view.frame = CGRectMake(0, 46, 1024, 728);
    controller.controlStyle = MPMovieControlStyleFullscreen;
    [controller setFullscreen:YES animated:YES];
    controller.scalingMode = MPMovieScalingModeAspectFit;
    
    [self.view addSubview:controller.view];
    
    activeView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(537, 359, 30, 30)];
    //设置显示样式,见UIActivityIndicatorViewStyle的定义
    activeView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    
    //设置显示位置
    [activeView setCenter:CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2)];
    
    //设置背景色
    activeView.backgroundColor = [UIColor grayColor];
    
    //设置背景透明
    activeView.alpha = 0.5;
    
    [controller.view addSubview:activeView];
    
    [controller play];
    
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)backHome
{
    [activeView stopAnimating];
    [controller stop];
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)handleLoadStateDidChange:(NSNotification *)notification
{
    MPMovieLoadState state = [controller loadState];
    if (state & MPMovieLoadStateStalled) {
        [controller stop];
        [activeView startAnimating];
    }else if(state & MPMovieLoadStatePlaythroughOK){
        [activeView stopAnimating];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
