//
//  DetailVideoViewContoller.h
//  CityEconomyOnline
//
//  Created by a on 13-12-6.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "VedioViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "VideoDetail.h"
#import "MBProgressHUD.h"
@interface DetailVideoViewContoller : UIViewController
{
 //详细视频的对象
    VideoDetail * videoDetail ;
    NSString *   videoId ; // 视频 id、
    MBProgressHUD * hud ; 
    
}

@property (assign,nonatomic) UIViewController * viewController ;


@property (retain,nonatomic) UIView * videoView ; // 存放视频view

@property (retain,nonatomic) UILabel *  tiltleLabel ; // 视频标题

@property (retain,nonatomic) UILabel * subTitleLabel ; // 子标题

@property (retain,nonatomic)  UIWebView * contentWebView; // 显示 内容的webView

@property (retain,nonatomic) MPMoviePlayerController *moviePlayer  ;
// 初始化函数
-(id)initWithVideoId:(NSString * )_videoId ;

-(void)setVideoId:(NSString * ) _Videoid ;


-(void)setVideoDetail:(VideoDetail *)myVideoDetail ;

@end
