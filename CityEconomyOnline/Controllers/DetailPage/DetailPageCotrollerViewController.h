//
//  DetailPageCotrollerViewController.h
//  CityEconomyOnline
//
//  Created by 季程跃 on 13-10-13.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"

@class ASIWebPageRequest;
@interface DetailPageCotrollerViewController : UIViewController<UIWebViewDelegate>
{
   UIWebView *detailPage;
    ASIWebPageRequest *request;
    ASINetworkQueue *networkQueue;
    
}

@property(nonatomic,retain)  UIWebView *detailPage;
@property(nonatomic,retain) ASIWebPageRequest *request;
@property(nonatomic,retain)  UIImageView *view1;
@property(nonatomic,retain)  UIImageView *view2;

-(void)back;

@end
