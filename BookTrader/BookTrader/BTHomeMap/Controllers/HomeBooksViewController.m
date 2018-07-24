//
//  HomeBooksViewController.m
//  BookTrader
//
//  Created by Connor Clancy on 7/17/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "HomeBooksViewController.h"
#import "SimpleBookDetailViewController.h"
#import "BookCell.h"
#import <MapKit/MapKit.h>

@interface HomeBooksViewController () <MKMapViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *booksArray;



@end

@implementation HomeBooksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mapView.delegate = self;
    MKCoordinateRegion sfRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667), MKCoordinateSpanMake(0.1, 0.1));
    [self.mapView setRegion:sfRegion animated:false];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchBooks {
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"myBooksHomeToBookDetailSegue"]) {
        SimpleBookDetailViewController *bookDetailViewController = [segue destinationViewController];
        bookDetailViewController.navigationControl = @"bookshelf";
    } else {
        
    }
}




- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    BookCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"BookCell" forIndexPath:indexPath];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}



@end
