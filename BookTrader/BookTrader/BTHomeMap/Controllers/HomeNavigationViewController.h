//
//  HomeNavigationViewController.h
//  BookTrader
//
//  Created by Connor Clancy on 7/16/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface HomeNavigationViewController : UIViewController

@property (nonatomic) MKCoordinateRegion currentLocation;
@property (strong, nonatomic) User *user;

@end
