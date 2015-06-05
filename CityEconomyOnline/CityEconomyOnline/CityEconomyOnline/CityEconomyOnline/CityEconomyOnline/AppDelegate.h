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

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *_currentNav;
}

@property (strong, nonatomic) UIWindow *window;

@end
