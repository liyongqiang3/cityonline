//
//  CityTipsCell.h
//  CityEconomyOnline
//
//  Created by Tsoftime on 13-8-19.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityImage.h"
#define kCityHeight     207.0f
#define kCityWidth      243.0f
#define kCityTopSpace   18.0f
#define kCityBottomSpace 7

@protocol NextPageDelegate

-(void)goToNextPage:(UIButton *)sender;

@end


@interface CityTipsCell : UITableViewCell
{
    id<NextPageDelegate> delegate;
    NSMutableArray * imageButtons  ;// 图片按钮集合
}
@property (assign,nonatomic) UIViewController * viewController ;

@property(nonatomic,retain) id<NextPageDelegate> delegate;

//传进来的数据结构为：@[@{@"id":id,@"url":imageUrl,@"isFree":Yes},@"id":id,@"url":imageUrl,@"isFree":Yes},...]
- (void)loadCellData:(NSArray *)array;

-(void)loadCityImages:(NSMutableArray * )array ;
@end

