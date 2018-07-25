//
//  AddBookDetailsViewController.m
//  BookTrader
//
//  Created by Connor Clancy on 7/16/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "AddBookDetailsViewController.h"

@interface AddBookDetailsViewController ()
//UI
@property (strong, nonatomic) IBOutlet UIView *listView;
@property (strong, nonatomic) IBOutlet UIView *wantView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *bookControl;
@property (strong, nonatomic) IBOutlet UIImageView *bookCover;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
//variables
@property (strong, nonatomic) NSDictionary *images;
@end

@implementation AddBookDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"add details %f", self.currentLocation.center.latitude);
    NSURL *url = [NSURL URLWithString:self.
                  coverurl];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    //set UI
    self.titleLabel.text = self.title;
    self.authorLabel.text = self.author;
    self.dateLabel.text = self.date;
    self.bookCover.image = [UIImage imageWithData:imageData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)showNewView:(id)sender {
//segmented control to switch container views
    if(self.bookControl.selectedSegmentIndex==0){
        [UIView animateWithDuration:(0.5) animations:^{
            self.listView.alpha = 1;
            self.wantView.alpha = 0;
        }];
    } else {
        [UIView animateWithDuration:(0.5) animations:^{
            self.listView.alpha = 0;
            self.wantView.alpha = 1;
        }];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   if ([[segue identifier] isEqualToString:@"listBookSegue"]) {
        ListBookViewController *vc = [segue destinationViewController];
       vc.title = self.title;
       vc.author = self.author;
       vc.date = self.date;
       vc.coverurl = self.coverurl;
       vc.currentLocation = self.currentLocation;
   } else if ([[segue identifier] isEqualToString:@"requestBookSegue"]) {
       RequestBookViewController *vc = [segue destinationViewController];
       vc.title = self.title;
       vc.author = self.author;
       vc.date = self.date;
       vc.coverurl = self.coverurl;
       vc.currentLocation = self.currentLocation;
   }
   else {
     NSLog([segue identifier]);
   }
}

@end
