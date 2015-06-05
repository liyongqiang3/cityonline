//
//  CityHotButton.m
//  CityEconomyOnline
//
//  Created by a on 13-12-2.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "CityHotButton.h"
#import "FocusDetailViewController.h"
@implementation CityHotButton
@synthesize viewController = _viewController ;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self->httpImageButton = [[ HttpImageButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self->httpImageButton setImage:[UIImage imageNamed:@"Home_ScrollViewBg.png"] forState:UIControlStateNormal];
        [self->httpImageButton addTarget:self action:@selector(clickImageButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self->httpImageButton];
        
        
    }
    return self;
}


-(void)clickImageButton:(UIButton *)sender
{
    
    FocusDetailViewController * focusDetailView = [[FocusDetailViewController alloc]initWithDetailID:cityHot.cityHotID];
    [_viewController presentViewController:focusDetailView animated:YES completion:nil];
//    _viewController 
    NSLog(@"___进入详细页面————————");
    
}
// 文章的基本信息

-(void)setCityHot:(CityHot *)_cityHot
{
    self->cityHot = _cityHot ;
    
//    [self->ImageButton setImage:_cityHot.image forState:UIControlStateNormal];
//    [self->httpImageButton setHttpImage:_cityHot.imagePath];
    [self->httpImageButton setHttpImage:_cityHot.imagePath andSucceed:^{
        _cityHot.image = httpImageButton.myImage;
        
        
        
    } andFailed:^{
        
    }];
    
    
    
}





@end
