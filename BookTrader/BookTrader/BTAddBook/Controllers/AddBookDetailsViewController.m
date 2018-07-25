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


/*
- (IBAction)publishClicked:(id)sender {

    self.own = true;
    if (true) { // fix later when not testing
    //latitude
    //longitude
        CLLocationDegrees lat = self.currentLocation.center.latitude;
        CLLocationDegrees lon = self.currentLocation.center.longitude;
        self.bookLat = self.currentLocation.center.latitude;
        self.bookLon = self.currentLocation.center.longitude;
        self.p_bookLat = @(self.bookLat);
        self.p_bookLon = @(self.bookLon);
    } else {
        //use defaults
    }
    [Book addBookToDatabaseWithTitle:self.title withAuthor:self.author withCoverURL:self.coverurl withLatitude:self.p_bookLat withLongitude:self.p_bookLon withOwn:self.own withSell:self.sell withTrade:self.trade withGift:self.gift withUserID:@"this is my id" withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"posted book");
        } else {
            NSLog(@"%@", error);
        }
    }];

[self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)onRequest:(id)sender {
    self.own = false;
    
  /*  [Book addBookToDatabase:nil withAuthor: withDate: withCover: withSell: withTrade:nil withGift:nil withLongitude:nil withLatitude:nil withOwn:own
             withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
             }];
   */

/*
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)showNewView:(id)sender {
//segmented control to switch container views
    if(self.bookControl.selectedSegmentIndex==0){
        [UIView animateWithDuration:(0.5) animations:^{
            self.haveBookView.alpha = 1;
            self.wantBookView.alpha = 0;
        }];
    } else {

        [UIView animateWithDuration:(0.5) animations:^{
            self.haveBookView.alpha = 0;
            self.wantBookView.alpha = 1;     }];
    }
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   if ([[segue identifier] isEqualToString:@"listBookSegue"]) {
        ListBookViewController *vc = [segue destinationViewController];
       vc.title = self.title;
       vc.author = self.author;
       vc.date = self.date;
       vc.coverurl = self.coverurl;
       vc.currentLocation = self.currentLocation;
 } else {
     NSLog([segue identifier]);
}
}

@end
