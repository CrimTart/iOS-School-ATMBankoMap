//
//  CustomAnnotation.h
//  ATMBankoMap
//
//  Created by Admin on 12.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CustomAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic, readwrite) NSString *mytitle;
@property (nonatomic, strong) NSString *mysubtitle;

+(MKAnnotationView *) createViewAnnotationForMapView: (MKMapView *)mapView annotation: (id <MKAnnotation>)annotation;

@end
