//
//  CommonUtils.m
//  CityEconomyOnline
//
//  Created by Tsoftime on 13-8-14.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "CommonUtils.h"

static CommonUtils *instance = nil;

@implementation CommonUtils

+ (CommonUtils *)sharedUtils
{
    if (!instance) {
        instance = [[CommonUtils alloc] init];
    }
    return instance;
}

- (void)alertWithMessage:(NSString *)message
{
    if (!_alertHub) {
        _alertHub = [[MBProgressHUD alloc] initWithView:[[[UIApplication sharedApplication] delegate] window]];
        [[[[UIApplication sharedApplication] delegate] window] addSubview:_alertHub];
        _alertHub.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alert_error.png"]] autorelease];
        _alertHub.mode = MBProgressHUDModeCustomView;
        _alertHub.delegate = self;
        _alertHub.labelText = message;
        [_alertHub show:YES];
        [_alertHub hide:YES afterDelay:2];
    }
}
- (void)alertWithMessage:(NSString *)message andView:(UIView *)view
{
    MBProgressHUD * hud =[[MBProgressHUD alloc]initWithView:view];
    hud.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alert_error.png"]] autorelease];
    hud.mode = MBProgressHUDModeCustomView;
//    hud.delegate = self;
    hud.labelText = message;
    [view addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:2];
}
#pragma mark - MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [_alertHub removeFromSuperview];
    [_alertHub release];
    _alertHub = nil;
}


#pragma mark - 其他自定义方法

+ (UIButton *)getCustomButtonWithFrame:(CGRect)frame nomalImage:(NSString *)image1 hightImage:(NSString *)image2 target:(id)target action:(SEL)myAction
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setImage:[UIImage imageNamed:image1] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:image2] forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed:image2] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:image2] forState:UIControlStateSelected | UIControlStateHighlighted];
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:target action:myAction forControlEvents:UIControlEventTouchUpInside];
    return button;
  
}

+ (UILabel *)getCustomLabelWithFrame:(CGRect)frame text:(NSString *)text fontSize:(float)size textColor:(UIColor *)color
{
    UILabel *label = [[[UILabel alloc] initWithFrame:frame] autorelease];
    label.text = text;
    label.font = [UIFont systemFontOfSize:size];
    if (color) {
        label.textColor = color;
    }
    else{
        label.textColor = [UIColor whiteColor];
    }
    label.backgroundColor = [UIColor clearColor];
    
    return label;
}
@end
