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

// for test
#import "BTBookTestModel.h"


@interface HomeViewController () <MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (nonatomic) MKCoordinateRegion currentLocation;
@property (strong, nonatomic) NSArray *books;
@property (strong, nonatomic) NSArray *users;
@property (strong, nonatomic) NSArray *filteredData;


@end

@implementation HomeViewController

// Test functions


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set up map view
    self.mapView.delegate = self;
    MKCoordinateRegion sfRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667), MKCoordinateSpanMake(0.1, 0.1));
    [self.mapView setRegion:sfRegion animated:false];
    
    // set up search bar
    self.searchBar.delegate = self;
    self.searchBar.layer.borderWidth = 0.0;
    [self.searchBar setBackgroundImage:[UIImage new]];
    
    // user location
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.geocoder = [CLGeocoder new];
    [self.locationManager startUpdatingLocation];
    
    // populate users (test data now can switch to real data when exists)
    PFQuery *usersQuery = [PFQuery queryWithClassName:@"UserTest"];
    [usersQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            self.users = objects;
            NSLog(@"users updated: %lu", (unsigned long)self.users.count);
        }
    }];
    
    
    // populate books (test data now can switch to real data when exists)
    PFQuery *booksQuery = [PFQuery queryWithClassName:@"BookTest"];
    [booksQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            self.books = objects;
            NSLog(@"books updated: %lu", self.books.count);
        }
    }];

    
    
    
    
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





// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier]  isEqual: @"navigationSegue"]) {
        // for nav header
    } else if ([[segue identifier] isEqualToString:@"myBooksSegue"]) {
        // for my books
    } else {
        NSLog(@"error");
    }
}



- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (searchText.length != 0) {
        self.filteredData = [self.books filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(title contains[c] %@)", searchText]];
    }
    else {
        self.filteredData = self.books;
    }
}





@end
