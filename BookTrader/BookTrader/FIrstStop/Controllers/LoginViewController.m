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

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Handle clicks on the button
    [self.loginButton addTarget : self action : @selector (loginButtonClicked) forControlEvents : UIControlEventTouchUpInside ];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- ( void ) loginButtonClicked {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions : @[@"public_profile"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result , NSError *error ) {
        if ( error ) {
            NSLog (@"Process error" );
        } else if ( result . isCancelled ) {
            NSLog (@ "Canceled" );
            
        } else {
            NSLog (@"Logged in" );
        
    }
        
    }];
    
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
