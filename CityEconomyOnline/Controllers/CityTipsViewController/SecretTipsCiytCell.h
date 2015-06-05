//
//  SecretTipsCiytCell.h
//  CityEconomyOnline
//
//  Created by a on 13-12-4.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityButton.h"
#define kCityHeight     207.0f
#define kCityWidth      243.0f
#define kCityTopSpace   18.0f
#define kCityBottomSpace 7

@interface SecretTipsCiytCell : UITableViewCell
{
    NSMutableArray * cityTipsButtons ; //
}
//@property (retain,nonatomic) CityButton * cityButton ;//单一 城市按钮 ；；
//
@property (assign,nonatomic) UIViewController * viewController ;

-(void)setCityTipsButtons:(NSMutableArray *)_cityTipsButtons ;//城市信息

@end
