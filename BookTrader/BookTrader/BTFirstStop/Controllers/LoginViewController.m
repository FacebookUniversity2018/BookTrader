//
//  LoginViewController.m
//  BookTrader
//
//  Created by Connor Clancy on 7/16/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "User.h"
#import "ParseUI.h"
#import "BTUserDefualts.h"


@interface LoginViewController ()

@property (strong, nonatomic) NSDictionary *profileInfo;
@property (strong, nonatomic) User *currentUser;
@property BOOL logged;
@property BOOL shouldSegue;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shouldSegue = NO;
    
    // Handle clicks on the button
    [self.loginButton addTarget : self action : @selector (loginButtonClicked) forControlEvents : UIControlEventTouchUpInside ];
    
    if([FBSDKAccessToken currentAccessTokenIsActive]) {
        self.logged = YES;
        self.shouldSegue = YES;
    } else{
        self.logged = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- ( void ) loginButtonClicked {
    if(self.logged == YES) {
        // Logout
        if([FBSDKAccessToken currentAccessTokenIsActive]) {
            FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
            [login logOut];
            self.logged = NO;
            NSLog(@"Logout");
        }
    } else if (self.logged == NO){
        // Manage user's login session
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logInWithReadPermissions : @[@"public_profile"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result , NSError *error ) {
            if ( error ) {
                NSLog (@"Process error" );
            } else if ( result . isCancelled ) {
                NSLog (@ "Canceled" );
            } else {
                NSLog (@"Logged in" );
            }
            self.logged = YES;
        }];
    }
}

// Verify if user is already on Parse
- (void) userExists: (NSString *) userID {
    
    PFQuery *query = [PFQuery queryWithClassName:@"UserProfiles"];
    [query includeKey:@"userId"];
    [query whereKey:@"userId" containsString:userID];
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *users, NSError *error) {
        if (users != nil) {
            // do something with the array of object returned by the call
            NSLog(@"Successfully retrieved user if any %@", users);
            if(users.count == 0) {
                // Image URL
                NSString *urlString = self.profileInfo[@"picture"][@"data"][@"url"];
                

                // Add User to parse
                [User addUserToDatabase:[FBSDKAccessToken currentAccessToken].userID withFirstName:self.profileInfo[@"name"] withLastName:self.profileInfo[@"last_name"] withBio:nil withProfilePicture:urlString withBooks:[NSArray new] withWantBooks:[NSArray new] withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
                    if (succeeded) {
                        NSLog(@"User added to Parse");
                        [self performSegueWithIdentifier:@"loginToHomeSegue" sender:self];
                    } else {
                        NSLog(@"%@", error);
                    }
                    
                }];
                
            } else {
                // If user already exists segue
                [self performSegueWithIdentifier:@"loginToHomeSegue" sender:self];
            }
            self.shouldSegue = YES;
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void) viewDidAppear:(BOOL)animated {
    // Everytime the view appears
    if ([FBSDKAccessToken currentAccessToken ]) { // User is logged in, do work such as go to next view controller
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"name, picture"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSLog(@"User dictionary after log in:%@", result);
                 self.profileInfo = result;
                 [self userExists:[FBSDKAccessToken currentAccessToken].userID];
             }
         }];
        
    }
}


#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}
*/
@end
