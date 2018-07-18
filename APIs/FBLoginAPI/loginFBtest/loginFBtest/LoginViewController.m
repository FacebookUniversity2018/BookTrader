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

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
- (IBAction)onLogin:(id)sender {
    FBSDKLoginManager * login = [[ FBSDKLoginManager alloc ] init ]; [ login logInWithReadPermissions : @ [@ "public_profile" ] fromViewController : self handler : ^( FBSDKLoginManagerLoginResult * result , NSError * error )
    {
        if ( error ) {
            NSLog (@ "Process error" );
        } else if ( result . isCancelled ) {
            NSLog (@ "Canceled" );
        } else { NSLog (@"Logged in" ); }
    }];
}
    

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UINavigationController *navigationController = [segue destinationViewController];
    ProfileViewController *profileVC = (ProfileViewController *)[navigationController topViewController];
    
    FBSDKProfile *profile = [FBSDKProfile currentProfile];
    profileVC.username.text = profile.name;
}

@end
