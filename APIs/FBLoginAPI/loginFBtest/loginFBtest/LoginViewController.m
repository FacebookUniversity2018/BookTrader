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

@interface LoginViewController ()
    
    @property (strong, nonatomic) NSDictionary *profile;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([FBSDKAccessToken currentAccessToken ]) { // User is logged in, do work such as go to next view controller.
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"name, picture"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSLog(@"user:%@", result);
                 self.profile = result;
                 [self performSegueWithIdentifier:@"Profile" sender:self];
             }
         }];
        
    }
    
    FBSDKLoginButton * loginButton = [[ FBSDKLoginButton alloc ] init ];
    loginButton.readPermissions = @[@"public_profile"];
    // Optional: Place the button in the center of your view.
    loginButton . center = self . view . center ;
    [ self . view addSubview : loginButton ];
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

@end
