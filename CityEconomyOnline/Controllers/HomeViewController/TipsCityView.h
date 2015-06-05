//
//  TipsCityView.h
//  CityEconomyOnline
//
//  Created by a on 13-12-25.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewesVideo.h"
@interface TipsCityView : UIView
{
    
    
    NewesVideo * newesVideo  ;
    
}

@property (assign,nonatomic) UIViewController  * homeViewController ; // viewController
@property (retain,nonatomic) UILabel * titleLabel; // 标题
@property (retain,nonatomic) UIButton * imageButton;//
-(void)setNewesVideo:(NewesVideo *)_newesVideo ;
@end
