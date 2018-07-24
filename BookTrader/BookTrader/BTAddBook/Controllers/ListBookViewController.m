//
//  ListBookViewController.m
//  BookTrader
//
//  Created by Claudia Haddad on 7/23/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "ListBookViewController.h"

@interface ListBookViewController ()

//buttons
@property (strong, nonatomic) IBOutlet UIButton *sellButton;
@property (strong, nonatomic) IBOutlet UIButton *tradeButton;
@property (strong, nonatomic) IBOutlet UIButton *giftButton;
@property (strong, nonatomic) IBOutlet UITextField *priceField;
@property (strong, nonatomic) IBOutlet UIButton *locationButton;

//location
@property (nonatomic) CLLocationDegrees bookLat;
@property (nonatomic) CLLocationDegrees bookLon;
@property (nonatomic) NSValue *p_bookLat;
@property (nonatomic) NSValue *p_bookLon;

//booleans
@property (nonatomic, assign) BOOL sell;
@property (nonatomic, assign) BOOL trade;
@property (nonatomic, assign) BOOL gift;
@property (nonatomic, assign) BOOL location;
@property (nonatomic, assign) BOOL own;
@end


@implementation ListBookViewController 


- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)publishClicked:(id)sender {
    
    self.own = true;
    //if (true) { // fix later when not testing
        //latitude
        //longitude
     
   // } else {
        //use defaults
   // }
    CLLocationDegrees lat = self.currentLocation.center.latitude;
    CLLocationDegrees lon = self.currentLocation.center.longitude;
    self.bookLat = self.currentLocation.center.latitude;
    self.bookLon = self.currentLocation.center.longitude;
    self.p_bookLat = @(self.bookLat);
    self.p_bookLon = @(self.bookLon);
    [Book addBookToDatabaseWithTitle:self.title withAuthor:self.author withCoverURL:self.coverurl withLatitude:self.p_bookLat withLongitude:self.p_bookLon withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"I posted the book");
        } else {
            NSLog(@"%@", error);
        }
    }];
    
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)useCurrentLocation:(id)sender {
    if (!self.location) {
        self.location = true;
        [self.locationButton setImage:[UIImage imageNamed:@"iconmonstr-checkbox-4-240.png"] forState:UIControlStateNormal];
    } else if (self.location) {
        self.location = false;
        [self.locationButton setImage:[UIImage imageNamed:@"iconmonstr-checkbox-6-240.png"] forState:UIControlStateNormal];
        //set book location with defaults
    }
}
- (IBAction)sellClicked:(id)sender {

    if (!self.sell) {
        self.sell = true;
        [self.sellButton setImage:[UIImage imageNamed:@"iconmonstr-checkbox-4-240.png"] forState:UIControlStateNormal];
    } else if (self.sell) {
        self.sell = false;
        [self.sellButton setImage:[UIImage imageNamed:@"iconmonstr-checkbox-6-240.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)tradeClicked:(id)sender {
    if (!self.trade) {
        self.trade = true;
        [self.tradeButton setImage:[UIImage imageNamed:@"iconmonstr-checkbox-4-240.png"] forState:UIControlStateNormal];
    } else if (self.trade) {
        self.trade = false;
        [self.tradeButton setImage:[UIImage imageNamed:@"iconmonstr-checkbox-6-240.png"] forState:UIControlStateNormal];
    }
}
- (IBAction)giftClicked:(id)sender {
    if (!self.gift) {
        self.gift = true;
        [self.giftButton setImage:[UIImage imageNamed:@"iconmonstr-checkbox-4-240.png"] forState:UIControlStateNormal];
    } else if (self.gift) {
        self.gift = false;
        [self.giftButton setImage:[UIImage imageNamed:@"iconmonstr-checkbox-6-240.png"] forState:UIControlStateNormal];
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
