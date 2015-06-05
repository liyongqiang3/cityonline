//
//  TravelSmallView.h
//  CityEconomyOnline
//
//  Created by Tsoftime on 13-8-20.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTravelSmallViewWidth 111.0f
#define kTravelSmallViewHeight 111.0f
#import "NewesVideo.h"
#import  "MBProgressHUD.h"
#import "HttpImageButton.h"

@class TravelViewController;
@interface TravelSmallView : UIView
{
    HttpImageButton *httpImageButton;
    UILabel *_label;
    NewesVideo * myNewesVideo ;
    MBProgressHUD * hud ;
}
@property(assign,nonatomic) UIViewController  * travelViewController ;
- (void)setContentWithData:(NSDictionary *)dicData;

-(void)setNewesVideo:(NewesVideo *)_newesVideo ;

@end
