//
//  OwnerViewController.h
//  CityEconomyOnline
//
//  Created by a on 13-12-19.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OwnerViewController : UIViewController<UIScrollViewDelegate>
{
    NSMutableArray * ownerImages ;// 图片的
    
}
-(id)initWithOwnerImages:(NSMutableArray *)_ownerImages ;

@property(retain,nonatomic) UIScrollView * listView ; // 

@end
