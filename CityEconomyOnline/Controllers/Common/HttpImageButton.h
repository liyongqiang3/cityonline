//
//  HttpImageButton.h
//  CityEconomyOnline
//
//  Created by a on 14-2-13.
//  Copyright (c) 2014年 TSoftime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HttpImageButton : UIButton
{
   
    
}
@property (retain,nonatomic) UIImage * myImage ;


-(void)setHttpImage:(NSString *)imageUrl  andSucceed:(void(^)())succeed  andFailed:(void(^)())failed ;

@end
