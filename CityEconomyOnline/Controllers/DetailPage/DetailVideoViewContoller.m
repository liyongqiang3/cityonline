//
//  DetailVideoViewContoller.m
//  CityEconomyOnline
//
//  Created by a on 13-12-6.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "DetailVideoViewContoller.h"
#import "VideoRequest.h"

@interface DetailVideoViewContoller ()

@end

@implementation DetailVideoViewContoller
@synthesize subTitleLabel = _subTitleLabel ;
@synthesize tiltleLabel = _tiltleLabel ;
@synthesize contentWebView = _contentWebView ;
@synthesize moviePlayer = _moviePlayer ;
@synthesize videoView = _videoView ;
@synthesize viewController = _viewController ;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
-(id)initWithVideoId:(NSString *)_videoId
{
    self = [super init];
    if (self) {
        self->videoId = _videoId;
    }
    return self ;
}
-(void)setVideoId:(NSString *)_Videoid
{
    self->videoId = _Videoid ;
}
-(void)setVideoDetail:(VideoDetail *)myVideoDetail
{
    self->videoDetail = myVideoDetail ;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //
    self.view.backgroundColor = [UIColor blackColor];
    
    UITabBar *navTabBar = [[UITabBar alloc]initWithFrame:CGRectMake(0, 0, 1024, 44)];
    [navTabBar setBackgroundImage:[UIImage imageNamed:@"SecondNavBar_Bg"]];
    [self.view addSubview:navTabBar];
    //上面的还回
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 5, 45, 40)];
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 11, 10, 11);
    [leftBtn setImage:[UIImage imageNamed:@"back_01.png"] forState:UIControlStateNormal];
    
    [leftBtn addTarget:self action:@selector(backHome) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * homeBtn = [[UIButton alloc]initWithFrame:CGRectMake(70, 5, 40, 35)];
    homeBtn.imageEdgeInsets = UIEdgeInsetsMake(7.5, 8, 7.5,8) ;
    [homeBtn setImage :[UIImage imageNamed:@"home_01.png"] forState:UIControlStateNormal];
    [homeBtn addTarget:self action:@selector(backHomeViewController:) forControlEvents:UIControlEventTouchUpInside];
    [navTabBar addSubview:homeBtn];
    
    [navTabBar addSubview:leftBtn];
    //分割线
    UIView  * seperatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 1024, 1)];
    seperatorView.backgroundColor = RGBCOLOR(59, 59, 59);
    _videoView = [[UIView alloc]initWithFrame:CGRectMake(0, 46, 1024, 450)];
    _videoView.backgroundColor = [UIColor clearColor];
    

    //// 添加中间标题
    UIView * titleView  =[[UIView alloc]initWithFrame:CGRectMake(0, 506, 1024, 80)];
    _tiltleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 500, 55)];
    _subTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, 1024, 25)];
    _subTitleLabel.textColor = [UIColor whiteColor];
    _subTitleLabel.font = [UIFont systemFontOfSize:14];
    _tiltleLabel.font = [UIFont systemFontOfSize:26];
    _tiltleLabel.textColor = [UIColor whiteColor];
    _tiltleLabel.backgroundColor = [UIColor clearColor];
    _subTitleLabel.backgroundColor = [UIColor clearColor];
    
    [titleView addSubview:_tiltleLabel];
    [titleView addSubview:_subTitleLabel];
    UIView  * seperatorView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 576, 1024, 1)];
        //分割线
    seperatorView1.backgroundColor = RGBCOLOR(59, 59, 59);
    
    [self.view addSubview:seperatorView1];
    
    UIView  * seperatorView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 116, 1024, 1)];
    //分割线
    seperatorView2.backgroundColor = RGBCOLOR(59, 59, 59);
    
//    [self.view addSubview:seperatorView2];
    

    [self.view addSubview:titleView];
    [self.view addSubview:navTabBar];
    [self.view addSubview:seperatorView];
    [self.view addSubview:_videoView];
    
    _contentWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 577, 1024, 292)];
    _contentWebView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_contentWebView];
    _contentWebView.hidden = YES ;
    hud = [[MBProgressHUD alloc]init];
    hud.labelText = @"loading......";
    [hud show:YES];
    [_videoView addSubview:hud];
    [self httpGetData];
    
    
    
}
-(void)initMoveView
{
    //<html><body bgcolor=#000000 > <font  color=#FFFFFF>%@ </font></body></html>
    //@"http://www.jxvdy.com/file/upload/201309/18/18-10-03-19-3.mp4"
    
    
    _moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:self->videoDetail.filePath]];
    [_moviePlayer.view setFrame:CGRectMake(250,70, 500, 400)];
     _moviePlayer.controlStyle = MPMovieControlStyleDefault;
    _moviePlayer.view.userInteractionEnabled = YES ;
    

 _moviePlayer.scalingMode = MPMovieScalingModeAspectFit ;
    [self.view addSubview:_moviePlayer.view];

    [_moviePlayer play];
    _tiltleLabel.text = self->videoDetail.title;
    _subTitleLabel.text = self->videoDetail.subtiltle ;
    _contentWebView.hidden = NO ;
    if (videoDetail.desp != nil) {
        [_contentWebView loadHTMLString:[NSString stringWithFormat:@"<html><body bgcolor=#000000 > <font  color=#FFFFFF>%@ </font></body></html>",videoDetail.desp] baseURL:nil];
    }
    
    
    
}
-(void)httpGetData
{
    VideoRequest * request = [[VideoRequest alloc]init];
    NSMutableArray * videosArray = [[NSMutableArray alloc]init];
    
    [request requestVideoDetailWithIndex:[videoId integerValue] andArray:videosArray onSuccess:^{
        
        self->videoDetail  = [videosArray objectAtIndex:0];
        [self initMoveView];
        [hud hide:YES];
        
        
    } onFailed:^{
;
        
         [hud hide:YES];
        [self initPrompt];
    }];
    
}
-(void)initPrompt
{

    CommonUtils  * utils = [[CommonUtils alloc]init];
    [utils alertWithMessage:@"网络有点不给力！" andView:self.view];
    
    

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidDisappear:(BOOL)animated
{
     [_moviePlayer stop];
    [_moviePlayer.view removeFromSuperview];
    
}
-(void)backHome
{
    [_moviePlayer stop];
    [_moviePlayer.view removeFromSuperview]; 
//    _moviePlayer = nil ;
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:^{
        _contentWebView = nil;
        _tiltleLabel = nil;
        _moviePlayer = nil ;
        _videoView = nil ;
        _subTitleLabel = nil ;
        videoDetail = nil ;
        NSLog(@"sgjksgjksjgkljsgikjskl---wgwg");
    }];
    
}
-(void)backHomeViewController:(UIButton *)sender
{
       [self dismissViewControllerAnimated:NO completion:^{
           
          [_viewController dismissViewControllerAnimated:NO completion:^{
              
              [[NSNotificationCenter defaultCenter]postNotificationName:BACK_HOME object:nil];
          }];
           
       }];
}

@end
