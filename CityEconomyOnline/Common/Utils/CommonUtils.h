//
//  CommonUtils.h
//  CityEconomyOnline
//
//  Created by Tsoftime on 13-8-14.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface CommonUtils : NSObject<MBProgressHUDDelegate>
{
    //提示框
    MBProgressHUD *_alertHub;
}

+ (CommonUtils *)sharedUtils;

//消息提示
- (void)alertWithMessage:(NSString *)message;

+ (UIButton *)getCustomButtonWithFrame:(CGRect)frame nomalImage:(NSString *)image1 hightImage:(NSString *)image2 target:(id)target action:(SEL)myAction;

+ (UILabel *)getCustomLabelWithFrame:(CGRect)frame text:(NSString *)text fontSize:(float)size textColor:(UIColor *)color;
// 提示消息
- (void)alertWithMessage:(NSString *)message andView:(UIView *)view ;

@end
