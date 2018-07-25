//
//  BookDetailViewController.m
//  BookTrader
//
//  Created by Connor Clancy on 7/16/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "BookDetailViewController.h"
#import "Book.h"
#import "User.h"
#import <FBSDKMessengerShareKit/FBSDKMessengerShareKit.h>
#import "UIImageView+AFNetworking.h"
#import "BTUserDefualts.h"


@interface BookDetailViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *bookCover;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) User *bookOwner;
@property (strong, nonatomic) User *currentUser;
@end

@implementation BookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getUserWithID:self.book.userID];
    NSURL *url = [NSURL URLWithString:self.book.coverurl];
    [self.bookCover setImageWithURL:url];
    self.titleLabel.text = self.book.title;
    self.authorLabel.text = self.book.author;
    self.dateLabel.text = self.book.date;
    NSDictionary *user = [BTUserDefualts getCurrentUser];
    self.currentUser = [User initUserWithDictionary:user];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}


- (IBAction)messageButtonPressed:(id)sender {
    [FBSDKMessengerSharer openMessenger];
}

- (IBAction)homeButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"bookDetailsToHome" sender:nil];
}

- (IBAction)favoriteBook:(id)sender {
    [self.currentUser addToBooksWant:self.book.title];
    NSLog(@"%@", self.currentUser);
}

- (void) getUserWithID: (NSString *) userID {
    PFQuery *query = [PFQuery queryWithClassName:@"UserProfiles"];
    [query includeKey:@"userId"];
    [query whereKey:@"userId" containsString:userID];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if(!error) {
            self.bookOwner = objects[0];
            NSLog(@"Book Owner User: %@", self.bookOwner);
        } else {
            NSLog(@"%@", error.localizedDescription);
            self.bookOwner = nil;
        }
    }];
}

@end
