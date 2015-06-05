//
//  CityTipsCell.m
//  CityEconomyOnline
//
//  Created by Tsoftime on 13-8-19.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "CityTipsCell.h"
#import "TipsInfoViewController.h"
#import "ImageButton.h"
@implementation CityTipsCell
@synthesize delegate;
@synthesize viewController = _viewController ;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self->imageButtons = [[NSMutableArray alloc]init];
        
        // Initialization code
        self.selectionStyle  = UITableViewCellSelectionStyleNone;
        
//        for (int i = 0; i < 3; i ++) {
//            ImageButton  *imageButton = [[[ImageButton alloc] initWithFrame:CGRectMake(20 + i * (28 + kCityWidth), kCityTopSpace, kCityWidth, kCityHeight)] autorelease];
//            imageButton.tag = i + 50;
//            imageButton.viewController = _viewController ;
//
//            [self addSubview:imageButton];
//            [self->imageButtons addObject:imageButton];
//            
//            
//        }
        self.backgroundColor  = [UIColor clearColor];
    }
    return self;
}

- (void)loadCellData:(NSArray *)array
{
    int index = 0;
    for (UIButton *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            if (index >= [array count])
                return;
//
//            [((UIButton *)view) setImage:[UIImage imageNamed:@"CityTipsCity.png"] forState:UIControlStateNormal];
            index ++ ;
        }
    }
}
// 加载图片
-(void)loadCityImages:(NSMutableArray * )array
{
    
    for (int i = 0 ; i < [array count]; i ++) {
        
        
        ImageButton  *imageButton = [[[ImageButton alloc] initWithFrame:CGRectMake(20 + i * (28 + kCityWidth), kCityTopSpace, kCityWidth, kCityHeight)] autorelease];
        imageButton.tag = i + 50;
        imageButton.viewController = _viewController ;
        
        [self addSubview:imageButton];
       
        [imageButton setCityImage:[array objectAtIndex:i]];
        
    }
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    for (UIView *tempView in self.subviews) {
        if ([tempView isKindOfClass:[UITableViewCell class]]) {
            [(UITableViewCell *)tempView prepareForReuse];
        }
    }
    
}

- (void)clickCityButton:(UIButton *)sender
{
        [delegate goToNextPage:sender];
}

@end
