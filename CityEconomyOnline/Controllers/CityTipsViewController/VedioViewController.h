//
//  VedioViewController.h
//  CityEconomyOnline
//
//  Created by 季程跃 on 13-11-7.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface VedioViewController : UIViewController
{
    MPMoviePlayerController *controller;
    UIActivityIndicatorView *activeView;
    int addressId;
    NSMutableArray *tvAddress;
}
@property(nonatomic,strong) MPMoviePlayerController *player;
@property int addressId;
@property(nonatomic,strong) NSMutableArray *tvAddress;
@end
