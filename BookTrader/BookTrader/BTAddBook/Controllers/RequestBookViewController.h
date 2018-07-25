//
//  RequestBookViewController.h
//  BookTrader
//
//  Created by Claudia Haddad on 7/23/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddBookDetailsViewController.h"
#import "Book.h"

@interface RequestBookViewController : UIViewController

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *coverurl;
@property (nonatomic) MKCoordinateRegion currentLocation;


@end
