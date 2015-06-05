//
//  AppDelegate.m
//  CityEconomyOnline
//
//  Created by Tsoftime on 13-8-13.
//  Copyright (c) 2013年 TSoftime. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //初始化数据库
    //初始化设置参数
    [self initializeUserDefaults];
    //初始化消息通知
    [self initializeNotifications];
    //初始化控制器
    [self initializeController];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    //关闭数据库
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    //打开数据库
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    //当出现内存警告时候，清空图片所占内存
}

//初始化设置参数
- (void)initializeUserDefaults
{
    NSDictionary *initialDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:3.0f],kDefaultSliderTime, nil];
    for (NSString *key in [initialDic allKeys]) {
        if (![[NSUserDefaults standardUserDefaults] objectForKey:key]) {
            [[NSUserDefaults standardUserDefaults] setObject:[initialDic objectForKey:key] forKey:key];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}

//初始化控制器
- (void)initializeController
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    
    MyRootViewController *myRootViewController = [[[MyRootViewController alloc] init] autorelease];
    
    //导航控制器
    UINavigationController *navigationController = [[[UINavigationController alloc] initWithRootViewController:myRootViewController] autorelease];
    if ([navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
       [navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavigationBar_Bg.png"] forBarMetrics:UIBarMetricsDefault];
    }
    else{
        [navigationController.navigationBar setBackgroundColor:RGBCOLOR(42, 42, 42)];
    }
    self.window.rootViewController = navigationController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

//初始化消息通知
- (void)initializeNotifications
{
    
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    _currentNav = (UINavigationController *)viewController;
}

@end
