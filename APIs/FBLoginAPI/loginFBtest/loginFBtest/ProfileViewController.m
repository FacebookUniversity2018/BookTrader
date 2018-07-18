//
//  ProfileViewController.m
//  loginFBtest
//
//  Created by Chaliana Rolon on 7/17/18.
//  Copyright © 2018 Chaliana Rolon. All rights reserved.
//

#import "ProfileViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController ()
    
    @property (weak, nonatomic) IBOutlet UIImageView *rawImage;
    
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Succesfully loaded Profile VC");
    self.username.text = self.name;
    [self.profileImage setImageWithURL:self.pictureURL];
    
    // Code to retrieve the UIImage raw data
    NSData *imageData = [NSData dataWithContentsOfURL:self.pictureURL];
    UIImage *image = [UIImage imageWithData:imageData];
    if(image!=nil) {
        NSLog(@"Image retrieved");
        self.rawImage.image = image;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
