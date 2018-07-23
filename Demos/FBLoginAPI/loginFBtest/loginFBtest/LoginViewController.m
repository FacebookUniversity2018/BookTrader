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
#import "Parse.h"

@interface LoginViewController ()
    
    @property (strong, nonatomic) NSDictionary *profile;

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated {
    
    if ([FBSDKAccessToken currentAccessToken ]) { // User is logged in, do work such as go to next view controller.
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"name, picture"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSLog(@"user:%@", result);
                 self.profile = result;
                 [self userExists:[FBSDKAccessToken currentAccessToken].userID];
             }
         }];
        
    }
    
}

// TRY IN LOG IN
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
                // create new user
                NSString *urlString = self.profile[@"picture"][@"data"][@"url"];
                NSURL *url = [NSURL URLWithString:urlString];
                NSData *imageData = [NSData dataWithContentsOfURL:url];
                UIImage *image = [UIImage imageWithData:imageData];
                PFFile *imageFile = [self getPFFileFromImage:image];
                /* Create user with same info to pass on
                [User addUserToDatabase:[FBSDKAccessToken currentAccessToken].userID withFirstName:self.profileInfo[@"first_name"] withLastName:self.profileInfo[@"last_name"] withBio:nil withProfilePicture:[self getPic:self.profileInfo[@"picture"][@"data"][@"url"]] withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
                    if(error) {
                        NSLog(@"%@", error.localizedDescription);
                    } else {
                        NSLog(@"User added to Parse");
                    }
                }];*/
            } else {
                // segue
                
            }
            // shouldsegue
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

/**
 Method to convert UIImage to PFFile:
 
 - parameter image: Image that the user wants to upload to parse
 - returns: PFFile for the the data in the image
 */
- (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image {
    
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFile fileWithName:@"image.png" data:imageData];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ProfileViewController *profileVC = [segue destinationViewController];
    profileVC.name = self.profile[@"name"];
    
    // PASS ON USER
    
}

@end
