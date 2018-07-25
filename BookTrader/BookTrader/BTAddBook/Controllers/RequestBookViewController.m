//
//  RequestBookViewController.m
//  BookTrader
//
//  Created by Claudia Haddad on 7/23/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "RequestBookViewController.h"
#import "Book.h"

@interface RequestBookViewController ()
//UI
@property (strong, nonatomic) IBOutlet UIButton *locationButton;

//location
@property (nonatomic) CLLocationDegrees bookLat;
@property (nonatomic) CLLocationDegrees bookLon;
@property (nonatomic) NSValue *p_bookLat;
@property (nonatomic) NSValue *p_bookLon;

//booleans
@property (nonatomic, assign) BOOL location;
@property (nonatomic, assign) BOOL own;

@end

@implementation RequestBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)requestClicked:(id)sender {
    self.own = false;

    self.bookLat = self.currentLocation.center.latitude;
    self.bookLon = self.currentLocation.center.longitude;
    self.p_bookLat = @(self.bookLat);
    self.p_bookLon = @(self.bookLon);
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
