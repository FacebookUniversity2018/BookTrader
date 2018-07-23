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
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "User.h"
#import "ParseUI.h"

@interface HomeNavigationViewController () <MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet PFImageView *profileImageView;

// Manage Logge in User
@property (strong, nonatomic) User *currUser;
@property BOOL userExist;
@property (strong, nonatomic) NSDictionary *profileInfo;

@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;

@end

@implementation HomeNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getUserWithID:[FBSDKAccessToken currentAccessToken].userID];
    
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

// Get user with the given ID from Parse
- (void) getUserWithID:(NSString *)userID {
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    [query includeKey:@"userId"];
    [query whereKey:@"userId" containsString:userID];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if(!error) {
            self.currUser = objects[0];
            self.usernameLabel.text = self.currUser.firstName;
            self.profileImageView.file = self.currUser.profilePicture;
            [self.profileImageView loadInBackground];
            
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

// Add user to parse
- (void) createUser {
    [User addUserToDatabase:[FBSDKAccessToken currentAccessToken].userID withFirstName:self.profileInfo[@"first_name"] withLastName:self.profileInfo[@"last_name"] withBio:nil withProfilePicture:[self getPic:self.profileInfo[@"picture"][@"data"][@"url"]] withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if(error) {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
}

// Verify if user is already on Parse
- (void) userExists: (NSString *) userID {
    
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    [query includeKey:@"userId"];
    [query whereKey:@"userId" containsString:userID];
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *users, NSError *error) {
        if (users != nil) {
            // do something with the array of object returned by the call
            NSLog(@"Successfully retrieved user if any %@", users);
            if(users.count == 0) {
                self.userExist = NO;
            } else {
                self.userExist = YES;
            }
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

// Get profile iage
- (PFFile *) getPic: (NSString *) url {
    
    // Code to retrieve the UIImage
    NSURL *picURL = [NSURL URLWithString:url];
    NSData *imageData = [NSData dataWithContentsOfURL:picURL];
    UIImage *image = [UIImage imageWithData:imageData];
    
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imagePNGData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imagePNGData) {
        return nil;
    }
    
    return [PFFile fileWithName:@"profile_image.png" data:imageData];
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
