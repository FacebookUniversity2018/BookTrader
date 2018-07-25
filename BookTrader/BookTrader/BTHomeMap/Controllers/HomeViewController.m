//
//  HomeViewController.m
//  BookTrader
//
//  Created by Connor Clancy on 7/16/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "HomeViewController.h"
#import "Book.h"
#import "HomeNavigationViewController.h"
#import "HomeBooksViewController.h"
#import "BTUserDefualts.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "BTUserDefualts.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "PinAnnotation.h"




@interface HomeViewController () <MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (nonatomic) MKCoordinateRegion currentLocation;
@property (strong, nonatomic) NSArray *books;
@property (strong, nonatomic) NSArray *users;
@property (strong, nonatomic) NSArray *filteredData;
@property BOOL locationFlag;
@property (strong, nonatomic) NSArray *booksArray;
@property (strong, nonatomic) NSArray *myBooks;

@end

@implementation HomeViewController

// Test functions


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // get user defaults
    CLLocationCoordinate2D myLocation = [BTUserDefualts getCurrentLocation];
    
    // set up map view
    self.mapView.delegate = self;
    self.currentLocation = MKCoordinateRegionMake(myLocation, MKCoordinateSpanMake(0.1, 0.1));
    [self.mapView setRegion:self.currentLocation animated:false];
    
    // set up search bar
    self.searchBar.delegate = self;
    self.searchBar.layer.borderWidth = 0.0;
    [self.searchBar setBackgroundImage:[UIImage new]];
    
    // user location
    self.locationFlag = true;
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.geocoder = [CLGeocoder new];
    [self.locationManager startUpdatingLocation];

}

- (void)viewDidAppear:(BOOL)animated {
    [self fetchBooks];
    [self fetchMyBooks];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(nonnull NSError *)error {
    NSLog(@"I failed");
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if (self.locationFlag) {
        CLLocation *location = [locations lastObject];
        MKCoordinateRegion currentLocation = MKCoordinateRegionMake(CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude), MKCoordinateSpanMake(0.1, 0.1));
        self.currentLocation = currentLocation;
        [self.mapView setRegion:currentLocation animated:true];
        self.locationFlag = false;
        [BTUserDefualts setCurrentLocation:currentLocation];
        
    } else {
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateLocation {
    
}


- (void)fetchBooks {
    PFQuery *query = [PFQuery queryWithClassName:@"Book"];
    query.limit = 100;
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            self.booksArray = objects;
            // update map with pins of books
            [self updateBookLocations:self.booksArray];
        }
    }];
}

- (void)fetchMyBooks {
    PFQuery *query = [PFQuery queryWithClassName:@"Book"];
    [query includeKey:@"userID"];
    [query whereKey:@"userID" containsString:[FBSDKAccessToken currentAccessToken].userID];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            self.myBooks = objects;
        }
    }];
}

- (void)updateBookLocations:(NSArray *)books {
    for (int i = 0; i < books.count; i++) {
        Book *book = books[i];
        if (book.latitude && book.latitude) {
            // create location to drop pin
            
            CLLocationCoordinate2D centerPoint;
            centerPoint.latitude = [book.latitude doubleValue];
            centerPoint.longitude = [book.longitude doubleValue];
//            MKPointAnnotation *annotation = [MKPointAnnotation new];
//            [annotation setCoordinate:centerPoint];
//            [annotation setTitle:book.title];
            PinAnnotation *annotation = [[PinAnnotation alloc] initWithLocation:centerPoint title:book.title isbn:book.isbn owner:self.currentUser];
            [self.mapView addAnnotation:annotation];
        }
    }
}





// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier]  isEqual: @"navigationSegue"]) {
        // for nav header
        NSLog(@"Home location %f", self.currentLocation.center.latitude);
        HomeNavigationViewController *navViewController = [segue destinationViewController];
        navViewController.currentLocation = self.currentLocation;
        navViewController.user = self.currentUser;
        navViewController.myBooks = self.booksArray;
        
    } else if ([[segue identifier] isEqualToString:@"myBooksSegue"]) {
        HomeBooksViewController *booksViewController = [segue destinationViewController];
        booksViewController.myBooks = self.myBooks;
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

// map stuff
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    NSString *identifier = @"identity";
    
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    MKAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    annotationView.canShowCallout = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    PinAnnotation *pinAnnotation = view.annotation;
    NSLog(@"THIS IS THE PIN ANNOTATION %@", pinAnnotation.isbn);
 //   [self performSegueWithIdentifier:@"myBooksSegue" sender:view];
}


@end
