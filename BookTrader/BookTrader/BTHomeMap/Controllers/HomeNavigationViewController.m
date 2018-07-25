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
#import "PersonalUserViewController.h"
#import "HomeViewController.h"
#import <MapKit/MapKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "UIImageView+AFNetworking.h"
#import <FBSDKMessengerShareKit/FBSDKMessengerShareKit.h>
#import "BTUserDefualts.h"

@interface HomeNavigationViewController () <MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@end

@implementation HomeNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *user = [BTUserDefualts getCurrentUser];
    self.user = [User initUserWithDictionary:user];
    
    self.usernameLabel.text = self.user.firstName;
    NSURL *url = [NSURL URLWithString:self.user.profilePicture];
    [self.profileImageView setImageWithURL:url];
    
    // set up map view
    self.mapView.delegate = self;
    [self.mapView setRegion:self.currentLocation animated:false];
    
    // set up profile image
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    self.profileImageView.clipsToBounds = YES;
    
    NSLog(@"NAVIGATION USER: %@", self.user);
}

- (IBAction)tappedMessages:(id)sender {
    [FBSDKMessengerSharer openMessenger];
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
    if ([[segue identifier]  isEqual: @"homeProfilePictureToProfileSegue"] || [[segue identifier]  isEqual: @"navToProfileSegue"]) {
        PersonalUserViewController *profileViewController = [segue destinationViewController];
        profileViewController.myBooks = self.myBooks;
    
    } else if ([[segue identifier] isEqualToString:@"navToProfileSegue"]) {
       
    } else if ([[segue identifier] isEqualToString:@"navToBarcodeSegue"]) {
        BarcodeAddViewController *barcodeViewController = [segue destinationViewController];
        barcodeViewController.currentLocation = self.currentLocation;
    } else if ([[segue identifier] isEqualToString:@"homeToMessagesSegue"]) {
        MessagesHomeViewController *messagesViewController = [segue destinationViewController];
        messagesViewController.navigationControl = @"navView";
    } else if ([[segue identifier] isEqualToString:@"SignOut"]){
        
    } else if ([[segue identifier] isEqualToString:@"navToHomeSegue"]) {

    }
}


@end
