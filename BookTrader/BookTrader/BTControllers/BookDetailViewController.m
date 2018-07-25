//
//  BookDetailViewController.m
//  BookTrader
//
//  Created by Connor Clancy on 7/16/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "BookDetailViewController.h"
#import "Book.h"
#import <FBSDKMessengerShareKit/FBSDKMessengerShareKit.h>

@interface BookDetailViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *bookCover;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@end

@implementation BookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", self.book);
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

@end
