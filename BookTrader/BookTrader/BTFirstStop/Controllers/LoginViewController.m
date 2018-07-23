//
//  LoginViewController.m
//  BookTrader
//
//  Created by Connor Clancy on 7/16/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeNavigationViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "User.h"
#import "UIImageView+AFNetworking.h"


@interface LoginViewController ()

@property BOOL logged;
@property BOOL shouldSegue;
@property NSString *usersName;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shouldSegue = NO;
    
    // Handle clicks on the button
    [self.loginButton addTarget : self action : @selector (loginButtonClicked) forControlEvents : UIControlEventTouchUpInside ];
    
    if([FBSDKAccessToken currentAccessToken]) {
        self.logged = YES;
        self.shouldSegue = YES;
    } else {
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
            self.shouldSegue = YES;
        }];
    }
}

- (void) viewDidAppear:(BOOL)animated {
    // Everytime the view appears
    if(self.logged==YES && self.shouldSegue) {
        [self performSegueWithIdentifier:@"loginToHomeSegue" sender:self];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    
}


@end
