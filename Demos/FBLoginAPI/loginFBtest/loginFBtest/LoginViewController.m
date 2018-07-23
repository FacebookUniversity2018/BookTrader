//
//  LoginViewController.m
//  loginFBtest
//
//  Created by Chaliana Rolon on 7/17/18.
//  Copyright © 2018 Chaliana Rolon. All rights reserved.
//

#import "LoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "ProfileViewController.h"
#import "FBSDKProfile.h"
#import "ProfielCheckViewController.h"
#import "User.h"
#import "Parse/Parse.h"

@interface LoginViewController ()
@property (strong, nonatomic) NSDictionary *profile;
@property BOOL userExist;
@property BOOL shouldSegue;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    FBSDKLoginButton * loginButton = [[ FBSDKLoginButton alloc ] init ];
    loginButton.readPermissions = @[@"public_profile"];
    // Optional: Place the button in the center of your view.
    loginButton . center = self . view . center ;
    [ self . view addSubview : loginButton ];
}

- (void)viewDidAppear:(BOOL)animated {
    if ([FBSDKAccessToken currentAccessToken ]) { // User is logged in, do work such as go to next view controller.
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"name, picture"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 self.profile = result;
                 [self userExists:[FBSDKAccessToken currentAccessToken].userID];
                 
             }
         }];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ProfileViewController *profileVC = [segue destinationViewController];
    profileVC.name = self.profile[@"name"];
    
    NSString *urlString = self.profile[@"picture"][@"data"][@"url"];
    profileVC.pictureURL = [NSURL URLWithString:urlString];
    NSLog(@"%@", profileVC.pictureURL);
    
}

- (void) userExists: (NSString *) userID {
    
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    [query includeKey:@"userId"];
    [query whereKey:@"userId" containsString:userID];
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *users, NSError *error) {
        if (users != nil) {
            // do something with the array of object returned by the call
            NSLog(@"Successfully retrieved user if any %@", users);
            if (users.count == 0) {
                // create new user
                NSString *urlString = self.profile[@"picture"][@"data"][@"url"];
                NSURL *url = [NSURL URLWithString:urlString];
                NSData *imageData = [NSData dataWithContentsOfURL:url];
                UIImage *image = [UIImage imageWithData:imageData];
                PFFile *pic = [User getPFFileFromImage:image];
                [User addUserToDatabase:[FBSDKAccessToken currentAccessToken].userID withFirstName:self.profile[@"name"] withLastName:self.profile[@"name"] withBio:nil withProfilePicture:pic withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
                    if (succeeded) {
                        NSLog(@"success");
                        [self performSegueWithIdentifier:@"Profile" sender:self];
                    } else {
                        NSLog(@"%@", error);
                    }
                }];
            } else {
                // segue
                [self performSegueWithIdentifier:@"Profile" sender:self];
            }
            self.shouldSegue = YES;
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

@end
