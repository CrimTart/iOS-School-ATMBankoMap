//
//  BankoList.m
//  ATMBankoMap
//
//  Created by Admin on 12.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "BankoList.h"
#import "CustomAnnotation.h"

@interface BankoList()

@property (nonatomic, strong) NSMutableArray *mapAnnotations;

@end

static const char key[] = "AIzaSyALRbeAncyqpxvGS2YGGkbENHXarw00D9U";
//"AIzaSyDKfCdJ5BPL27dPCPHBjmoY9ufRBzBBXIs";

@implementation BankoList

-(instancetype) init {
    self = [super init];
    if (self) {

        self.mapAnnotations = [NSMutableArray new];
    }
    return self;
}

-(NSArray *) getAnnotations {
    return self.mapAnnotations;
}

-(void) downloadItems: (CLLocation*)mylocation withCompletionHandler:(void (^)(void))completionHandler{
    self.mapAnnotations = [[NSMutableArray alloc] init];
    
    NSString *openNow = @"opennow";
    NSString *apikey = [NSString stringWithUTF8String:key];
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&keyword=atm&rankby=distance&%@&key=%@", mylocation.coordinate.latitude, mylocation.coordinate.longitude, openNow, apikey]];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"network error %@", error.userInfo);
        }
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (!json) {
            NSLog(@"NSJSONSerialization error %@", error);
        }
        else {
            if (json[@"error_message"]) {
                NSLog(@"error %@", json[@"error_message"]);
            }
            else {
                for (NSDictionary *dictionary in json[@"results"]) {
                    CustomAnnotation *item = [[CustomAnnotation alloc] init];
                    
                    item.mytitle = dictionary[@"name"];
                    
                    NSDictionary *coordinate = dictionary[@"geometry"][@"location"];
                    NSString *lat_s = coordinate[@"lat"];
                    double lat_bank = lat_s.doubleValue;
                    NSString *lng_s = coordinate[@"lng"];
                    double lng_bank = lng_s.doubleValue;
                    item.coordinate = CLLocationCoordinate2DMake(lat_bank, lng_bank);
                    [self.mapAnnotations addObject:item];
                }
                completionHandler();
            }
        }
    }];
    
    [task resume];
}

@end
