//
//  AppDelegate.m
//  ATMBankoMap
//
//  Created by Admin on 12.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "AppDelegate.h"
#import "BankoMapViewController.h"
#import "BankoTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UITabBarController *tabbar = [[UITabBarController alloc] init];
    UIViewController *vc1 = [BankoMapViewController new];
    UIViewController *vc2 = [BankoTableViewController new];
    tabbar.viewControllers = @[vc1, vc2];
    self.window.rootViewController = tabbar;
    return YES;
}

@end
