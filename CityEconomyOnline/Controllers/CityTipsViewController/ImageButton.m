//
//  ImageButton.m
//  CityEconomyOnline
//
//  Created by a on 13-12-24.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "ImageButton.h"
#import "TipsInfoViewController.h"
@implementation ImageButton
@synthesize cityButton = _cityButton ;
@synthesize viewController = _viewController ;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _cityButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
//        imageButton.tag = i + 50;
        [_cityButton addTarget:self action:@selector(clickCityButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_cityButton];
        
    }
    return self;
}

-(void)clickCityButton:(UIButton * )sender
{
    NSLog(@"sjkgjksjgksjgkjskgjskjgksjg");
    if (![self->myCityImage.cityName isEqualToString:@"beijing"]) {
        return ;
    }
    TipsInfoViewController *tip = [[TipsInfoViewController alloc]init];
    
    //    [self presentModalViewController:tip animated:YES];
    [_viewController presentViewController:tip animated:YES completion:nil];
}
-(void)setCityImage:(CityImage *)cityImage
{
    self->myCityImage = cityImage ;
    [_cityButton setImage:cityImage.image forState:UIControlStateNormal];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
