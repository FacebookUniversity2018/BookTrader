//
//  SimpleBookDetailViewController.m
//  BookTrader
//
//  Created by Claudia Haddad on 7/17/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "SimpleBookDetailViewController.h"

@interface SimpleBookDetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *bookCover;

@end

@implementation SimpleBookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tappedBackButton:(id)sender {
    if ([self.navigationControl isEqualToString:@"profile"]) {
        [self performSegueWithIdentifier:@"bookDetailsToProfileSegue" sender:nil];
    } else if ([self.navigationControl isEqualToString:@"bookshelf"]) {
        [self performSegueWithIdentifier:@"bookDetailsToBookshelfSegue" sender:nil];
    } else {
        NSLog(@"back button in book details broken because of navigation");
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
