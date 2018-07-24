//
//  AddBookDetailsViewController.h
//  BookTrader
//
//  Created by Connor Clancy on 7/16/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"
#import "User.h"
#import "BarcodeAddViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface AddBookDetailsViewController : UIViewController
@property NSString *isbn;
@property (strong, nonatomic) Book *book;
@property (nonatomic) MKCoordinateRegion currentLocation;
@property (strong, nonatomic) NSDictionary *currentBook;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *coverurl;
@property (strong, nonatomic) User *currentUser;
@end
