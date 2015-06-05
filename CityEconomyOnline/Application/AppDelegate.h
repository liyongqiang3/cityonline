//
//  AppDelegate.h
//  CityEconomyOnline
//
//  Created by Tsoftime on 13-8-13.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyRootViewController.h"
#import "HomeViewController.h"
#import "TravelViewController.h"
#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *_currentNav;
    Reachability* hostReach;
    Reachability* internetReach;
    Reachability* wifiReach;
}

@property (strong, nonatomic) UIWindow *window;

@end
