//
//  AppDelegate.m
//  LoveLife
//
//  Created by 周 加飞 on 14-9-23.
//  Copyright (c) 2014年 com.zhouxingxing.www. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseNavigationController.h"
#import "BaseTabBarController.h"
#import "TuanViewController.h"
#import "NearViewController.h"
#import "MyViewController.h"
#import "MoreViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //团购
    TuanViewController *tuanVC = [[TuanViewController alloc] init];
    BaseNavigationController *tuanNav = [[BaseNavigationController alloc] initWithRootViewController:tuanVC];
    tuanNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"团购" image:[UIImage imageNamed:@"icon_tuangou"] selectedImage:[[UIImage imageNamed:@"icon_tuangou_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //周边
    NearViewController *zhoubianVC = [[NearViewController alloc] init];
    BaseNavigationController *zhoubianNav = [[BaseNavigationController alloc] initWithRootViewController:zhoubianVC];
    zhoubianNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"周边" image:[UIImage imageNamed:@"icon_near"] selectedImage:[[UIImage imageNamed:@"icon_near_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //我的
    MyViewController *myVC = [[MyViewController alloc] init];
    BaseNavigationController *myNav = [[BaseNavigationController alloc] initWithRootViewController:myVC];
    myNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"icon_my"] selectedImage:[[UIImage imageNamed:@"icon_my_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //更多
    MoreViewController *moreVC = [[MoreViewController alloc] init];
    BaseNavigationController *moreNav = [[BaseNavigationController alloc] initWithRootViewController:moreVC];
    moreNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"更多" image:[UIImage imageNamed:@"icon_more"] selectedImage:[[UIImage imageNamed:@"icon_more_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //设置TabBarItem上面字体的颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f],
                                                        NSForegroundColorAttributeName : [UIColor orangeColor]
                                                        } forState:UIControlStateSelected];
    
    
    BaseTabBarController *tab = [[BaseTabBarController alloc] init];
    tab.viewControllers = @[tuanNav,zhoubianNav,myNav,moreNav];
    
    self.window.rootViewController = tab;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
