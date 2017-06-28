//
//  BankoMapViewController.h
//  ATMBankoMap
//
//  Created by Admin on 12.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLLocationManager;

@interface BankoMapViewController : UIViewController

-(void) centerOn: (NSInteger)annotationNumber;
-(instancetype) initWithLocationManager: (CLLocationManager *)locationManager;

@end
