//
//  CustomAnnotation.m
//  ATMBankoMap
//
//  Created by Admin on 12.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "CustomAnnotation.h"

@implementation CustomAnnotation

// required if you set the MKPinAnnotationView's "canShowCallout" property to YES
-(NSString *) title {
    return _mytitle;
}

// optional
-(NSString *) subtitle {
    return _mysubtitle;
}

+(MKAnnotationView *) createViewAnnotationForMapView: (MKMapView *)mapView annotation: (id <MKAnnotation>)annotation {
    MKPinAnnotationView *returnedAnnotationView =
    (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:NSStringFromClass([CustomAnnotation class])];
    if (returnedAnnotationView == nil) {
        returnedAnnotationView =
        [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                        reuseIdentifier:NSStringFromClass([CustomAnnotation class])];
        
        returnedAnnotationView.pinTintColor = MKPinAnnotationView.greenPinColor;
        returnedAnnotationView.animatesDrop = YES;
        returnedAnnotationView.canShowCallout = YES;
        
        UIButton *drawRouteBtn = [UIButton buttonWithType:UIButtonTypeInfoLight];
        drawRouteBtn.tag = 1;
        returnedAnnotationView.rightCalloutAccessoryView = drawRouteBtn;
    }
    return returnedAnnotationView;
}

@end
