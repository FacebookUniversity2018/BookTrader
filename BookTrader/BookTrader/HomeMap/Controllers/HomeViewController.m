//
//  HomeViewController.m
//  BookTrader
//
//  Created by Connor Clancy on 7/16/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "HomeViewController.h"
#import "Book.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

// testing imports
#import "BTUserTestModel.h"
#import "BTBookTestModel.h"

@interface HomeViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (nonatomic) MKCoordinateRegion currentLocation;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // this is just here for testing right now
    // add test user to database
    /*
    [BTUserTestModel BTAddUserToDatabase:@"0000003" withFirstName:@"Dafeng" withLastName:@"Jin" withBio:@"Now us four are all in here" withImage:nil withMyBooksArray:nil withWantBooksArray:nil withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"yay, posted");
        } else {
            NSLog(@"didn't work");
        }
    }];
    */
    CLLocationCoordinate2D location00 = CLLocationCoordinate2DMake(37.783333, -122.416567);
    CLLocationCoordinate2D location01 = CLLocationCoordinate2DMake(37.783333, -122.42);
    CLLocationCoordinate2D location02 = CLLocationCoordinate2DMake(37.783333, -122.4162);
    CLLocationCoordinate2D location03 = CLLocationCoordinate2DMake(37.783333, -122.41662);
    CLLocationCoordinate2D location04 = CLLocationCoordinate2DMake(37.783333, -122.416262);
    CLLocationCoordinate2D location05 = CLLocationCoordinate2DMake(37.75, -122.416667);
    CLLocationCoordinate2D location06 = CLLocationCoordinate2DMake(37.785, -122.416667);
    CLLocationCoordinate2D location07 = CLLocationCoordinate2DMake(37.7835, -122.416667);
    CLLocationCoordinate2D location08 = CLLocationCoordinate2DMake(37.783335, -122.416667);
    CLLocationCoordinate2D location09 = CLLocationCoordinate2DMake(37.7833335, -122.416667);
    
    // set up map view
    self.mapView.delegate = self;
    MKCoordinateRegion sfRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667), MKCoordinateSpanMake(0.1, 0.1));
    [self.mapView setRegion:sfRegion animated:false];
    
    // set up search bar
    self.searchBar.layer.borderWidth = 0.0;
    [self.searchBar setBackgroundImage:[UIImage new]];
    
    // user location
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.geocoder = [CLGeocoder new];
    
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(nonnull NSError *)error {
    NSLog(@"I failed");
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    MKCoordinateRegion currentLocation = MKCoordinateRegionMake(CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude), MKCoordinateSpanMake(0.1, 0.1));
    self.currentLocation = currentLocation;
    // NSLog([NSString stringWithFormat:@"%f", location.coordinate.latitude]);
    // NSLog([NSString stringWithFormat:@"%f", location.coordinate.longitude]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateLocation {
    
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
