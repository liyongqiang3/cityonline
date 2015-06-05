//
//  TipsCityView.m
//  CityEconomyOnline
//
//  Created by a on 13-12-25.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "TipsCityView.h"
#import "TipsInfoViewController.h"
@implementation TipsCityView
@synthesize titleLabel = _titleLabel ;
@synthesize  imageButton = _imageButton ;
@synthesize  homeViewController = _homeViewController ;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
          self.backgroundColor = RGBCOLOR(59, 58, 58);
        CGFloat  y = frame.size.height  -  27 ;
        
        _titleLabel = [CommonUtils getCustomLabelWithFrame:CGRectMake(10, y, frame.size.width - 15, 20) text:@"" fontSize:15 textColor:nil];
        [self addSubview:_titleLabel];
        _imageButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _imageButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 27, 0);
        [_imageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_imageButton];
    }
    return self;
}

-(void)setNewesVideo:(NewesVideo *)_newesVideo
{
    self->newesVideo = _newesVideo ;
    _titleLabel.text = _newesVideo.title ;
    [_imageButton setImage:_newesVideo.image forState:UIControlStateNormal];
    
}
-(void)imageButtonClick:(UIButton *)sender
{
//    if (![self->newesVideo.title isEqualToString:@"文化中心--北京"]) {
//        return ;
//    }
    TipsInfoViewController * tipsInfoView = [[TipsInfoViewController alloc]init];
    [_homeViewController presentViewController:tipsInfoView animated:YES completion:nil];
    
//    NSLog(@"进入城市锦囊");
    
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
