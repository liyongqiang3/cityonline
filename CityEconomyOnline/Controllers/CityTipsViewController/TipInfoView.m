//
//  TipInfoView.m
//  CityEconomyOnline
//
//  Created by a on 14-2-11.
//  Copyright (c) 2014年 TSoftime. All rights reserved.
//

#import "TipInfoView.h"
#import "TravelViewController.h"
#import "TravelBigView.h"
#import "PowerpointViewController.h"
#import "Reachability.h"
#import "CommonUtils.h"
@implementation TipInfoView
@synthesize _contentLabel;
//@synthesize  ;
@synthesize traverViewController = _traverViewController ;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, 245, 210);
        
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 164, 245, 46)];
        hud = [[MBProgressHUD alloc]init];
        //        _bgImageView.backgroundColor = [UIColor blackColor];
        [hud show:YES];
        
        _bgImageView.image = [UIImage imageNamed:@"Travel_BigViewBg.png"];
        [self addSubview:_bgImageView];
        
        _contentLabel = [CommonUtils getCustomLabelWithFrame:CGRectMake(20, 15, 200, 16) text:@"" fontSize:15 textColor:nil];
        [_bgImageView addSubview:_contentLabel];
        
        httpImageButton = [[HttpImageButton alloc] initWithFrame:CGRectMake(0, 0, 245, 210)];
        httpImageButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 46, 0);
        [httpImageButton addTarget:self action:@selector(travelCityClickBigView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:httpImageButton];
        index = 0;
        [self addSubview:hud];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTimer:) name:STOPTIME object:nil];
        
      
    }
    return self;
}

- (void)setContentWithData:(NSDictionary *)dicData
{
    
    [httpImageButton setImage:[dicData objectForKey:@"image"] forState:UIControlStateNormal];
    _contentLabel.text = [dicData objectForKey:@"contentLabel"];
    
}

// 设置图片的 基本信息
-(void)setImageModelArray:(NSMutableArray *)_imageModels
{
    [hud hide:YES];
    [hud removeFromSuperview];
    self->imageModels = _imageModels ;
    if ([_imageModels count] == 0) {
        return ;
    }
    ImageModel * myImageModel = [_imageModels objectAtIndex:0];
    _contentLabel.text =  myImageModel.landscape_name ;
    [httpImageButton setImage:myImageModel.image forState:UIControlStateNormal];
    myTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
}
//  切换图片
-(void)changeImage
{
    if ([self->imageModels count] <= 2) {
        return ;
    }
    ImageModel * myImageModel = [self->imageModels objectAtIndex:index];
    index ++ ;
    if (imageModel.image == nil) {
        [httpImageButton setHttpImage:myImageModel.imageUrl andSucceed:^{
            myImageModel.image = httpImageButton.myImage;
            NSLog(@"－－－33-－－");
        } andFailed:^{
            
            
        }];
        
    } else {
         [httpImageButton setImage:myImageModel.image forState:UIControlStateNormal];
    }
   
    if (index  >= [self->imageModels count]) {
        index = 0;
    }
    
}

// 是城市锦囊的时候
- (void)setImageModel:(ImageModel *)_imageModel
{
    [hud hide:YES];
    [hud removeFromSuperview];
    
    self->imageModel = _imageModel ;
//    [httpImageButton setImage:imageModel.image forState:UIControlStateNormal];
//    [httpImageButton setHttpImage:_imageModel.imageUrl];
    [httpImageButton setHttpImage:_imageModel.imageUrl andSucceed:^{
        imageModel.image = httpImageButton.myImage ;
        NSLog(@"sjgkjskdgj--sdgds");
        
    } andFailed:^{
    
    }];
    
    _contentLabel.text =  imageModel.landscape_name ;
    
}
- (void)travelCityClickBigView:(UIButton *)sender
{
    Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    if ([r currentReachabilityStatus] ==NotReachable ) {
        CommonUtils * untils = [[CommonUtils alloc]init];
        [untils alertWithMessage:@"网络有点不给力～！" andView: _traverViewController.view ];
        return ;
    }
   
        //
        self->imageModel = [self->imageModels objectAtIndex:0 ];
        PowerpointViewController *  power = [[PowerpointViewController alloc]initWithImageModel:self->imageModel ];
        power.type = 1 ;
    power.viewController =  _traverViewController ;
    
    
    
        power.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [_traverViewController presentViewController:power animated:YES completion:nil];
        CLog(@"跳转到幻灯片");
    
   
    
    
}
// 定时器停止
-(void)removeTimer:(NSNotification *)notyf
{
    
    NSLog(@"sjkgk99999(((((");
    [myTimer invalidate];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:STOPTIME object:nil];
    
    
}
@end
