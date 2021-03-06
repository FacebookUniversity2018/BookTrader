//
//  PinAnnotation.h
//  BookTrader
//
//  Created by Connor Clancy on 7/25/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "User.h"
#import "Book.h"

@interface PinAnnotation : NSObject <MKAnnotation>
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) Book *book;
@property (strong, nonatomic) User *owner;

- (instancetype)initWithLocation:(CLLocationCoordinate2D)coord title:(NSString *)title book:(Book *)book;
@end
