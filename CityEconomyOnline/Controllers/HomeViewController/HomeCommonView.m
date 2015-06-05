//
//  HomeCommonView.m
//  CityEconomyOnline
//
//  Created by Tsoftime on 13-8-17.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "HomeCommonView.h"
#import "DetailVideoViewContoller.h"
#import "HomeViewController.h"
#import "Reachability.h"
#import "CommonUtils.h"
@implementation HomeCommonView
//@synthesize homeViewController = _homeViewController ;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = RGBCOLOR(59, 58, 58);
        
        CGFloat y = kHomeVideoHeight - 27;
        if (frame.size.height != kHomeVideoHeight) {
            y = kHomeTipsHeight - 27;
        }
    
        _label = [CommonUtils getCustomLabelWithFrame:CGRectMake(10, y, frame.size.width - 15, 20) text:@"" fontSize:15 textColor:nil];
        [self addSubview:_label];
                
       
        httpImageButton = [[HttpImageButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        httpImageButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 27, 0);
        [httpImageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:httpImageButton];
        hud = [[MBProgressHUD alloc]init];
         hud.dimBackground = NO;
        [self  addSubview:hud];
        [hud show:YES];
        
    }
    return self;
}

- (void)setContentWithData:(NSDictionary *)dicData
{
    if (height(self) == kHomeVideoHeight) {
        [httpImageButton setImage:[UIImage imageNamed:@"videoRecommend.png"] forState:UIControlStateNormal];
        _label.text = @"中国经济是否回春天？";
    }
    else{
        [httpImageButton setImage:[UIImage imageNamed:@"TipsRecommond.png"] forState:UIControlStateNormal];
        [_label removeFromSuperview];
        _label.text = @"中国经济是否回春天虚拟消息？";
    }
}
-(void)setHomeViewController:(HomeViewController *)_homeViewController
{
    self->homeViewController = _homeViewController ;
}
- (void)imageButtonClick:(UIButton *)sender
{
    
    Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    if ([r currentReachabilityStatus] ==NotReachable ) {
        CommonUtils * untils = [[CommonUtils alloc]init];
        [untils alertWithMessage:@"网络有点不给力～！" andView:self->homeViewController.view];
        return ;
    }
    
    DetailVideoViewContoller * myDetailVideoViewController = [[DetailVideoViewContoller alloc]initWithVideoId:newesVideo.newesId];

    [self->homeViewController presentViewController:myDetailVideoViewController animated:YES
                                    completion:nil];

}

// 设置 初始化 程序
-(void)setNewesVideo:(NewesVideo *)_newesVideo
{
    [hud hide: YES];
    [hud removeFromSuperview];
    
    self->newesVideo = _newesVideo ;
//    [httpImageButton setImage:_newesVideo.image forState:UIControlStateNormal];
//    [httpImageButton setHttpImage:_newesVideo.imagePath];
    [httpImageButton setHttpImage:_newesVideo.imagePath andSucceed:^{
        
        
    } andFailed:^{
    
    }];
    
    
    _label.text =  self->newesVideo.title ;
    if (self.frame.size.height ==kHomeTipsHeight ) {
        _label.backgroundColor = [UIColor redColor];
    }
//    NSLog(@"%@",_label.text);
    
    
    
    
}
@end
