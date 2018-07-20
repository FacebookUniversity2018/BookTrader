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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *myArray = [NSMutableArray new];
    
    // [defaults setObject:currentLocation forKey:@"myLocation"];
}
@end
