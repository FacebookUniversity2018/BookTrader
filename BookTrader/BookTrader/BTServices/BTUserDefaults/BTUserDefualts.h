//
//  BTUserDefualts.h
//  BookTrader
//
//  Created by Connor Clancy on 7/20/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface BTUserDefualts : NSObject
+ (CLLocationCoordinate2D) getCurrentLocation;
+ (void) setCurrentLocation:(MKCoordinateRegion)currentLocation;
+ (void) setCurrentUserWithId:(NSString *)userId withName:(NSString *)name withPicture:(NSString *)profilePicture withBooks:(NSArray *)booksHave withoutBooks:(NSArray *)booksWant;

+ (NSDictionary *)getCurrentUser;
@end
