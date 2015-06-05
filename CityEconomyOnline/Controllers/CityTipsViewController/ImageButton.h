//
//  ImageButton.h
//  CityEconomyOnline
//
//  Created by a on 13-12-24.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityImage.h"
@interface ImageButton : UIView
{
    CityImage * myCityImage ;
    
}
@property ( retain,nonatomic) UIButton * cityButton ;

//@property ()
@property (retain,nonatomic) UIViewController * viewController ;

-(void)setCityImage:(CityImage *)cityImage ;

@end
