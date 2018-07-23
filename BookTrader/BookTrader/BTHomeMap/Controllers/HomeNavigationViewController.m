//
//  HomeNavigationViewController.m
//  BookTrader
//
// The User has looged in through facebook successfully
//
//  Created by Connor Clancy on 7/16/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "HomeNavigationViewController.h"
#import "BarcodeAddViewController.h"
#import "MessagesHomeViewController.h"
#import <MapKit/MapKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "ParseUI.h"

@interface HomeNavigationViewController () <MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet PFImageView *profileImageView;

// Manage Logged in User
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;

@end

@implementation HomeNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // set up map view
    self.mapView.delegate = self;
    MKCoordinateRegion sfRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667), MKCoordinateSpanMake(0.1, 0.1));
    [self.mapView setRegion:sfRegion animated:false];
    
    // set up profile image
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    self.profileImageView.clipsToBounds = YES;
    
    //[self getUserWithID:[FBSDKAccessToken currentAccessToken].userID];
    NSLog(@"%@", [FBSDKAccessToken currentAccessToken].userID);
    
    NSLog(@"NAV USER: %@", self.user);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

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
        //NSLog([segue identifier]);
    }
}


@end
