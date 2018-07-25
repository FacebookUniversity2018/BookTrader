//
//  BTUserDefualts.m
//  BookTrader
//
//  Created by Connor Clancy on 7/20/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "BTUserDefualts.h"

@implementation BTUserDefualts

+ (void)setCurrentLocation:(MKCoordinateRegion)currentLocation {
    NSDictionary *locationData = @{@"latitude":@(currentLocation.center.latitude), @"longitude":@(currentLocation.center.longitude)};
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:locationData forKey:@"myLocation"];
}

+ (CLLocationCoordinate2D)getCurrentLocation {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *locationDictionary = [defaults objectForKey:@"myLocation"];
    CLLocationCoordinate2D res = CLLocationCoordinate2DMake(0, 0);
    if (locationDictionary) {
        CLLocationDegrees latitude = [locationDictionary[@"latitude"] doubleValue];
        CLLocationDegrees longitude = [locationDictionary[@"longitude"] doubleValue];
        return CLLocationCoordinate2DMake(latitude, longitude);
    }
    else {
        return res;
    }
}



@end
