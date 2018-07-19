//
//  BTBookTestModel.m
//  BookTrader
//
//  Created by Connor Clancy on 7/19/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "BTBookTestModel.h"
#import "BTUserTestModel.h"
#import "Parse/Parse.h"

@implementation BTBookTestModel
@dynamic bookId;
@dynamic title;
@dynamic author;
@dynamic overview;
@dynamic genre;
@dynamic sell;
@dynamic gift;
@dynamic trade;
@dynamic location;
@dynamic user;

+ (nonnull NSString *)parseClassName {
    return @"BookTest";
}

+ (void) BTAddBookToDatabase:(NSString *)bookId withTitle:(NSString *)title withAuthor:(NSString *)author
                withOverview:(NSString *)overview withGenre:(NSString *)genre canSell:(BOOL)sell canGift:(BOOL)gift
                    canTrade:(BOOL)trade withLocation:(CLLocationCoordinate2D)location withUser:(BTUserTestModel *)user withCompletion:(PFBooleanResultBlock _Nullable)completion {
    BTBookTestModel *book = [BTBookTestModel new];
    book.bookId = bookId;
    book.title = title;
    book.author = author;
    book.overview = overview;
    book.genre = genre;
    book.sell = sell;
    book.gift = gift;
    book.trade = trade;
    book.location = location;
    
    [book saveInBackgroundWithBlock:completion];
};

@end
