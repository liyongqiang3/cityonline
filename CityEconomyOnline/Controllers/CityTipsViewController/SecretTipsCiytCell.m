//
//  SecretTipsCiytCell.m
//  CityEconomyOnline
//
//  Created by a on 13-12-4.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "SecretTipsCiytCell.h"
#import "SecretCityTip.h"
#import "ImagePdf.h"
@implementation SecretTipsCiytCell
//@synthesize cityButton = _cityButton ;
@synthesize viewController = _viewController ;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle  = UITableViewCellSelectionStyleNone;
        cityTipsButtons = [[NSMutableArray alloc]init];
        for (int i = 0; i < 3; i ++)
        {
            CityButton * cityButton = [[CityButton alloc]initWithFrame:CGRectMake(20 + i * (28 + kCityWidth), kCityTopSpace, kCityWidth, kCityHeight)];
            NSLog(@"--%f",(20 + i * (28 + kCityWidth)));
            [self addSubview:cityButton];
            [cityTipsButtons addObject:cityButton];
            
        }
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setCityTipsButtons:(NSMutableArray *)_cityTipsButtons
{
    
    for (int i = 0 ; i < [_cityTipsButtons count] ; i ++) {
        CityButton * myCityButton = [cityTipsButtons objectAtIndex:i];
//        ImagePdf * myImagePdf = [[ImagePdf alloc]init];
        myCityButton.viewController = _viewController ;
         ImagePdf * myImagePdf = [_cityTipsButtons objectAtIndex:i ];
        [myCityButton setSecretCityTip:myImagePdf];
        
    }
}
@end
