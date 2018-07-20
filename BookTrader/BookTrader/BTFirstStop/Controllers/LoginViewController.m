//
//  LoginViewController.m
//  BookTrader
//
//  Created by Connor Clancy on 7/16/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "LoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "User.h"


@interface LoginViewController ()

@property (strong, nonatomic) NSDictionary *profileInfo;
@property BOOL logged;
@property BOOL userExist;
@property BOOL shouldSegue;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shouldSegue = NO;
    
    if([FBSDKAccessToken currentAccessTokenIsActive]) {
        self.logged = YES;
        self.shouldSegue = YES;
    } else{
        self.logged = NO;
    }
    
    // Handle clicks on the button
    [self.loginButton addTarget : self action : @selector (loginButtonClicked) forControlEvents : UIControlEventTouchUpInside ];
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
                // Fetch user's information
                [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"name, picture, first_name, last_name"}]
                 startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                     if (!error) {
                         NSLog(@"user:%@", result);
                         self.profileInfo = result;
                         if(!self.userExist) {
                             [self createUser];
                         }
                         self.shouldSegue = YES;
                     }
                 }];
            }
            self.logged = YES;
        }];
    }
}

// Add user to parse
- (void) createUser {
    [User addUserToDatabase:[FBSDKAccessToken currentAccessToken].userID withFirstName:self.profileInfo[@"first_name"] withLastName:self.profileInfo[@"last_name"] withBio:nil withProfilePicture:nil withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
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
            self.shouldSegue = YES;
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void) viewDidAppear:(BOOL)animated {
    // Everytime the view appears
    [self userExists: [FBSDKAccessToken currentAccessToken].userID];
    if(self.logged==YES && self.shouldSegue) {
        [self performSegueWithIdentifier:@"loginToHomeSegue" sender:self];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
