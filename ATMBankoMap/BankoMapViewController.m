//
//  BankoMapViewController.m
//  ATMBankoMap
//
//  Created by Admin on 12.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "BankoMapViewController.h"
#import <MapKit/MapKit.h>
#import "CustomAnnotation.h"
#import "BankoList.h"

@interface BankoMapViewController () <MKMapViewDelegate, UIPopoverPresentationControllerDelegate>

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, copy) NSArray *mapAnnotations;

@end

@implementation BankoMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=UIColor.yellowColor;
    self.title=@"BankoMap";

    MKCoordinateRegion newRegion;
    newRegion.center.latitude = 40.731045;
    newRegion.center.longitude = -73.990691;
    newRegion.span.latitudeDelta = 0.2;
    newRegion.span.longitudeDelta = 0.2;
    
    _mapView=[MKMapView new];
    
    [self.mapView setRegion:newRegion animated:YES];
    
    self.view = _mapView;
    
    CLLocationDegrees lat = 40.731;
    CLLocationDegrees lng = -73.9906;
    CLLocation* location = [[CLLocation alloc] initWithLatitude:lat longitude:lng] ;
    
    BankoList *list = [[BankoList alloc] init];
    
    __weak typeof(self) weakself = self;
    [list downloadItems:location withCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.mapAnnotations = [list getAnnotations];
            [weakself.mapView addAnnotations:self.mapAnnotations];
        });
    }];
    
    self.mapAnnotations = [list getAnnotations];
    
    [self.mapView addAnnotations:self.mapAnnotations];
    [self.mapView setRegion:newRegion animated:YES];
}

-(void) centerOn: (NSInteger)annotationNumber {
    CustomAnnotation *annotation=self.mapAnnotations[annotationNumber];
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = annotation.coordinate.latitude;
    newRegion.center.longitude = annotation.coordinate.longitude;
    newRegion.span.latitudeDelta = 0.2;
    newRegion.span.longitudeDelta = 0.2;
    
    [self.mapView setRegion:newRegion animated:YES];
    [self.mapView selectAnnotation:annotation animated:YES];
}


@end
