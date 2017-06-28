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
#import "AppDelegate.h"

@interface BankoMapViewController () <MKMapViewDelegate>

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, copy) NSArray *mapAnnotations;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation BankoMapViewController

-(instancetype) initWithLocationManager: (CLLocationManager *)locationManager {
    self = [super init];
    if (self) {
        _locationManager = locationManager;
    }
    return self;
}

-(void) viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.yellowColor;
    self.title = @"BankoMap";

    MKCoordinateRegion newRegion = MKCoordinateRegionMakeWithDistance([self getCurrentUserCoordinate], 1000, 1000);
    
    self.mapView = [MKMapView new];
    
    [self.mapView setRegion:newRegion animated:YES];
    
    self.view = self.mapView;
    self.mapView.delegate = self;
    
    CLLocationDegrees lat = newRegion.center.latitude;
    CLLocationDegrees lng = newRegion.center.longitude;
    CLLocation* location = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
    
    BankoList *list = [[BankoList alloc] init];
    
    __weak typeof(self) weakself = self;
    [list downloadItems:location withCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.mapAnnotations = [list getAnnotations];
            [weakself.mapView addAnnotations:self.mapAnnotations];
        });
    }];
    [self.mapView setShowsUserLocation:YES];
}

-(void) centerOn: (NSInteger)annotationNumber {
    CustomAnnotation *annotation = self.mapAnnotations[annotationNumber];
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = annotation.coordinate.latitude;
    newRegion.center.longitude = annotation.coordinate.longitude;
    newRegion.span.latitudeDelta = 0.05;
    newRegion.span.longitudeDelta = 0.05;
    
    [self.mapView setRegion:newRegion animated:YES];
    [self.mapView selectAnnotation:annotation animated:YES];
}

-(MKAnnotationView *) mapView: (MKMapView *)mapView viewForAnnotation: (id <MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) return nil;
    if ([annotation isKindOfClass:[CustomAnnotation class]]) {
        return [CustomAnnotation createViewAnnotationForMapView:mapView annotation:annotation];
    }
    return nil;
}

-(CLLocationCoordinate2D) getCurrentUserCoordinate {
    return self.locationManager.location.coordinate;
}

-(void) getDirection: (MKAnnotationView *)destination {
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    request.source = [MKMapItem mapItemForCurrentLocation];
    
    CLLocationCoordinate2D destinationCoords = destination.annotation.coordinate;
    MKPlacemark *destinationPlacemark = [[MKPlacemark alloc] initWithCoordinate:destinationCoords addressDictionary:nil];
    MKMapItem *miDestination = [[MKMapItem alloc] initWithPlacemark:destinationPlacemark];
    
    request.destination = miDestination;
    request.requestsAlternateRoutes = NO;
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
        }
        else {
            [self showRoute:response];
        }
    }];
}

-(void) showRoute: (MKDirectionsResponse*)response {
    for (MKRoute *route in response.routes){
        [self.mapView addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
        
        for (MKRouteStep *step in route.steps){
            NSLog(@"%@,%f", step.instructions, step.distance);
        }
    }
}

-(MKOverlayRenderer *) mapView: (MKMapView *)mapView rendererForOverlay: (id<MKOverlay>)overlay {
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor blueColor];
    renderer.lineWidth = 5.0;
    return renderer;
}

-(void) mapView: (MKMapView *)mapView annotationView: (nonnull MKAnnotationView *)view calloutAccessoryControlTapped: (nonnull UIControl *)control {
    if (control.tag == 1){
        [self getDirection:view];
    }
}



@end
