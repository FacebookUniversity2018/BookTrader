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
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "ParseUI.h"

@interface HomeNavigationViewController () <MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet PFImageView *profileImageView;

@end

@implementation HomeNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // set up map view
    self.mapView.delegate = self;
    [self.mapView setRegion:self.currentLocation animated:false];
    
    // set up profile image
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    self.profileImageView.clipsToBounds = YES;
    
    NSLog(@"NAVIGATION USER: %@", self.user);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSignOut:(id)sender {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logOut];
    NSLog(@"Logout from Navigation Controller");
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
        
    }
}


@end
