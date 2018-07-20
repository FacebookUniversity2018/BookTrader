//
//  AddBookDetailsViewController.h
//  BookTrader
//
//  Created by Connor Clancy on 7/16/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"
#import "BarcodeAddViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface AddBookDetailsViewController : UIViewController
@property NSString *isbn;
@property (strong, nonatomic) Book *book;
@property (nonatomic) MKCoordinateRegion currentLocation;
@end
