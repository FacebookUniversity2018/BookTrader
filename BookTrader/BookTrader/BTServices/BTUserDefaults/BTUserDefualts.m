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
+ (void)setCurrentUserWithId:(NSString *)userId withName:(NSString *)name withPicture:(NSString *)profilePicture withBooks:(NSArray *)booksHave withoutBooks:(NSArray *)booksWant {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDict = @{@"id":userId,
                               @"name":name,
                               @"picture":profilePicture,
                               @"booksHave":booksHave,
                               @"booksWant":booksWant,
                               };
    [defaults setObject:userDict forKey:@"currentUser"];
}

+ (NSDictionary *)getCurrentUser {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *currentUser = [defaults objectForKey:@"currentUser"];
    return currentUser;
}
@end
