//
//  PersonalUserViewController.m
//  BookTrader
//
//  Created by Connor Clancy on 7/16/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "PersonalUserViewController.h"
#import "MessagesHomeViewController.h"
#import "SimpleBookDetailViewController.h"
#import "HomeNavigationViewController.h"
#import "ParseUI.h"

@interface PersonalUserViewController ()

@property (weak, nonatomic) IBOutlet PFImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@end

@implementation PersonalUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.usernameLabel.text = self.currentUser.firstName;
    self.profileImage.file = self.currentUser.profilePicture;
    [self.profileImage loadInBackground];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"profileToMessagesSegue"]) {
        MessagesHomeViewController *messagesViewController = [segue destinationViewController];
        messagesViewController.navigationControl = @"profileView";
    } else if ([[segue identifier] isEqualToString:@"personalProfileToBookDetailSegue"]) {
        SimpleBookDetailViewController *bookDetailViewController = [segue destinationViewController];
        bookDetailViewController.navigationControl = @"profile";
    } else if([[segue identifier] isEqualToString:@"profileToHomeSegue"]) {
        HomeNavigationViewController *homeNav = [segue destinationViewController];
        homeNav.user = self.currentUser;
    }
}


@end
