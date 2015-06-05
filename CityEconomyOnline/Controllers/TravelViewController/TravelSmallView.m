//
//  TravelSmallView.m
//  CityEconomyOnline
//
//  Created by Tsoftime on 13-8-20.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "TravelSmallView.h"
#import "DetailVideoViewContoller.h"
#import "TravelViewController.h"
#import "Reachability.h"
#import "CommonUtils.h"
@implementation TravelSmallView
@synthesize travelViewController = _travelViewController ;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _label = [CommonUtils getCustomLabelWithFrame:CGRectMake(0, 98, kTravelSmallViewWidth, 13) text:@"" fontSize:13 textColor:nil];
        [self addSubview:_label];
        httpImageButton = [[HttpImageButton alloc] initWithFrame:CGRectMake(0, 0, kTravelSmallViewWidth, kTravelSmallViewHeight)];
        [httpImageButton addTarget:self action:@selector(travelCityClickSmallView:) forControlEvents:UIControlEventTouchUpInside];
        httpImageButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 17, 0);
        [self addSubview:httpImageButton];
        hud = [[MBProgressHUD alloc]init];
        self.backgroundColor = [UIColor blackColor];
        [self addSubview:hud];
        [hud show:YES];
        
    }
    return self;
}

- (void)setContentWithData:(NSDictionary *)dicData
{
//    _imageButton getImage:[dicData objectForKey:@"imageUrl"];
    _label.text = [dicData objectForKey:@"content"];
    
//    [_imageButton setImage:[UIImage imageNamed:[dicData objectForKey:@"imageUrl"]] forState:UIControlStateNormal];
}


- (void)travelCityClickSmallView:(UIButton *)sender
{
    
    
    Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    if ([r currentReachabilityStatus] ==NotReachable ) {
        CommonUtils * untils = [[CommonUtils alloc]init];
        [untils alertWithMessage:@"网络有点不给力～！" andView:_travelViewController.view];
        return ;
    }
    DetailVideoViewContoller  * myDetailVedioViewController = [[DetailVideoViewContoller alloc]initWithVideoId:myNewesVideo.newesId];
    
    [_travelViewController presentViewController:myDetailVedioViewController animated:YES completion:nil];
//    CLog(@"城市旅游，旅游视频");
    
    
}

// 初始化数据
-(void)setNewesVideo:(NewesVideo *)_newesVideo
{
    [hud hide: YES];
    [hud removeFromSuperview];
    self.backgroundColor = [UIColor clearColor];
    self->myNewesVideo = _newesVideo ;

    [httpImageButton setHttpImage:_newesVideo.imagePath andSucceed:^{
        _newesVideo.image = httpImageButton.myImage ;
        
        
    } andFailed:^{
        
        
    }];
    
    
    _label.text = _newesVideo.title ;
}
@end
