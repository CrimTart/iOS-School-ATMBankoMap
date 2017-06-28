//
//  BankoTableViewController.h
//  ATMBankoMap
//
//  Created by Admin on 12.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLLocationManager;

@interface BankoTableViewController : UIViewController

-(instancetype) initWithLocationManager: (CLLocationManager *)locationManager;

@end
