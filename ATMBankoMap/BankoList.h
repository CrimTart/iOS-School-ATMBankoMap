//
//  BankoList.h
//  ATMBankoMap
//
//  Created by Admin on 12.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CLLocation;

@interface BankoList : NSObject

-(NSArray *) getAnnotations;
-(void) downloadItems: (CLLocation*)mylocation withCompletionHandler: (void (^)(void))completionHandler;

@end
