//
//  PinAnnotation.m
//  BookTrader
//
//  Created by Connor Clancy on 7/25/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "PinAnnotation.h"
@implementation PinAnnotation

- (instancetype)initWithLocation:(CLLocationCoordinate2D)coord title:(NSString *)title isbn:(NSString *)isbn owner:(User *)owner {
    self = [super init];
    if (self) {
        self.coordinate = coord;
        self.title = title;
        self.isbn = isbn;
        self.owner = owner;
    }
    return self;
}
@end
