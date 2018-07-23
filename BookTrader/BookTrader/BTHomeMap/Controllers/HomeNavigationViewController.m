//
//  HomeNavigationViewController.m
//  BookTrader
//
//  Created by Connor Clancy on 7/16/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "HomeNavigationViewController.h"
#import "BarcodeAddViewController.h"
#import "MessagesHomeViewController.h"
#import <MapKit/MapKit.h>
#import "User.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface HomeNavigationViewController () <MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) User *currUser;

@end

@implementation HomeNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // set up map view
    self.mapView.delegate = self;
    MKCoordinateRegion sfRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667), MKCoordinateSpanMake(0.1, 0.1));
    [self.mapView setRegion:sfRegion animated:false];
    
    // set up profile image
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    self.profileImageView.clipsToBounds = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    // Get the current logged in user
    self.currUser = [User getUserWithID:[FBSDKAccessToken currentAccessToken].userID];
    NSLog(@"%@", self.currUser);
}

/*
#pragma mark - Navigation
=======
>>>>>>> 2d2dd9299eccf2d09885f0b397e6593f1c1f0021:BookTrader/BookTrader/BTHomeMap/Controllers/HomeNavigationViewController.m

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier]  isEqual: @"homeProfilePictureToProfileSegue"]) {
        
    } else if ([[segue identifier] isEqualToString:@"navToProfileSegue"]) {
        
    } else if ([[segue identifier] isEqualToString:@"navToBarcodeSegue"]) {
        BarcodeAddViewController *barcodeViewController = [segue destinationViewController];
        barcodeViewController.currentLocation = self.currentLocation;
    } else if ([[segue identifier] isEqualToString:@"homeToMessagesSegue"]) {
        MessagesHomeViewController *messagesViewController = [segue destinationViewController];
        messagesViewController.navigationControl = @"navView";
    } else {
        NSLog([segue identifier]);
    }
}
*/

@end
