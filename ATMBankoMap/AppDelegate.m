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
#import <MapKit/MapKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

-(BOOL) application: (UIApplication *)application didFinishLaunchingWithOptions: (NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    _locationManager = [CLLocationManager new];
    if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [_locationManager requestWhenInUseAuthorization];
    }
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [_locationManager startUpdatingLocation];

    UITabBarController *tabbar = [[UITabBarController alloc] init];
    UIViewController *vc1 = [BankoMapViewController new];
    UIViewController *vc2 = [BankoTableViewController new];
    tabbar.viewControllers = @[vc1, vc2];
    
    self.window = window;
    self.window.rootViewController = tabbar;
    [window makeKeyAndVisible];
    
    return YES;
}

@end
