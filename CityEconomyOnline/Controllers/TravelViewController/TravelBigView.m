//
//  TravelBigView.m
//  CityEconomyOnline
//
//  Created by Tsoftime on 13-8-20.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//
#import "TravelViewController.h"
#import "TravelBigView.h"
#import "PowerpointViewController.h"
#import "Reachability.h"
#import "CommonUtils.h"
@implementation TravelBigView
@synthesize _contentLabel;
//@synthesize _imageButton;
@synthesize traverViewController = _traverViewController ;
- (id)initWithFrame:(CGRect)frame withType:(TravelBigViewType)type
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

        
        _myType = type;
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
//    [httpImageButton setImage:myImageModel.image forState:UIControlStateNormal];
    [httpImageButton setHttpImage:myImageModel.imageUrl andSucceed:^{
        myImageModel.image =   httpImageButton.myImage;
        
    } andFailed:^{
        
        
    }];
    
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
    if (myImageModel.image != nil) {
            [httpImageButton setImage:myImageModel.image forState:UIControlStateNormal];
    } else {
        [httpImageButton setHttpImage:myImageModel.imageUrl andSucceed:^{
            myImageModel.image = httpImageButton.myImage ;
            
            
        } andFailed:^{
            
        }];
        
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
//    [_imageButton setImage:imageModel.image forState:UIControlStateNormal];
    [httpImageButton setHttpImage:imageModel.imageUrl andSucceed:^{
        
        
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
    
    if (_myType == TravelBigViewSlider) {
//
        self->imageModel = [self->imageModels objectAtIndex:0 ];
        PowerpointViewController *  power = [[PowerpointViewController alloc]initWithImageModel:self->imageModel ];
        
        power.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [_traverViewController presentViewController:power animated:YES completion:nil];
        CLog(@"跳转到幻灯片");
         power = nil ;
    }
    else{
        
        PowerpointViewController *  power = [[PowerpointViewController alloc]initWithImageModel:self->imageModel];
        
        power.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [_traverViewController presentViewController:power animated:YES completion:nil];
        
        
        power = nil ;
        CLog(@"跳转到城市锦囊");
    }
    
    
}
// 定时器停止



@end

