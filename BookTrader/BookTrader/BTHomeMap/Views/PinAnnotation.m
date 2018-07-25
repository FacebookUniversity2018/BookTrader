//
//  PinAnnotation.m
//  BookTrader
//
//  Created by Connor Clancy on 7/25/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "PinAnnotation.h"
@implementation PinAnnotation

- (instancetype)initWithLocation:(CLLocationCoordinate2D)coord title:(NSString *)title book:(Book *)book {
    self = [super init];
    if (self) {
        self.coordinate = coord;
        self.title = title;
        self.book = book;
    }
    return self;
}
@end
