//
//  TalkMicroView.m
//  CityEconomyOnline
//
//  Created by Tsoftime on 13-8-17.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "CommonView.h"
//#import "LGPlayerViewController.h"
#import "DetailVideoViewContoller.h"
#import "Reachability.h"
#import "CommonUtils.h"
@implementation CommonView
{
    CommonViewType currentType;
}
@synthesize superViewController = _superViewController ;

- (id)initWithFrame:(CGRect)frame withType:(CommonViewType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, kCommonViewWidth, kCommonViewHeight);
        
        CGFloat y = kCommonViewHeight - 54;
        _label = [CommonUtils getCustomLabelWithFrame:CGRectMake(0, y, frame.size.width, 54) text:@"" fontSize:15 textColor:nil];
        _label.numberOfLines = 1;
        _label.lineBreakMode = NSLineBreakByTruncatingTail;
        [self addSubview:_label];
        
        CGFloat space = 54.0f;
        switch (type) {
            case TalkCity:
                _label.numberOfLines = 2;
                self.backgroundColor = RGBCOLOR(59, 58, 58);
                break;
            case MicroCity:               
                self.backgroundColor = RGBCOLOR(59, 58, 58);
                break;
            default:
                space = 0;
                break;
        }
        currentType = type;
        httpImageButton = [[HttpImageButton alloc] initWithFrame:CGRectMake(0, 0, kCommonViewWidth, kCommonViewHeight)];
        httpImageButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, space, 0);
        [httpImageButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:httpImageButton];
        hud = [[MBProgressHUD alloc]init];
        [hud show:YES];
        [self addSubview:hud];
        
    }
    return self;
}

- (void)setContentWithData:(NSDictionary *)dicData
{
    //    [_imageButton getImage:[dicData objectForKey:@"imageUrl"]];
    [httpImageButton setImage:[UIImage imageNamed:[dicData objectForKey:@"imageUrl"]] forState:UIControlStateNormal];
    _label.text = [dicData objectForKey:@"contentIntro"];
}
-(void)setNewesVideo:(NewesVideo *)_newesViedo
{
    [hud hide:YES];
    [hud removeFromSuperview];
    self->newesVideo = _newesViedo ;
//    [_imageButton setImage:_newesViedo.image forState:UIControlStateNormal];
    [httpImageButton setHttpImage:_newesViedo.imagePath andSucceed:^{
        
                
    } andFailed:^{
        
        
    }];
    
    _label.text = _newesViedo.title ;
    
}
- (void)buttonClick:(UIButton *)sender
{
    CLog(@"CommonView点击事件,根据不同type跳转不同的界面"); //newesVideo.tilte // newesVideo.moveurl ;
    
    Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    if ([r currentReachabilityStatus] ==NotReachable ) {
        CommonUtils * untils = [[CommonUtils alloc]init];
        [untils alertWithMessage:@"网络有点不给力～！" andView:self->_superViewController.view];
        return ;
    }
    
//    LGPlayerViewController * LGPlayer = [[LGPlayerViewController alloc]initWithMoveName:@"电台直播" andurl:self->newesVideo.moveUrl];
    DetailVideoViewContoller * myDetailVideoViewController = [[DetailVideoViewContoller alloc]initWithVideoId:self->newesVideo.newesId];
//    [_superViewController presentModalViewController:LGPlayer animated:YES];
    [_superViewController presentViewController:myDetailVideoViewController animated:YES completion:nil];
    
    
}

@end
