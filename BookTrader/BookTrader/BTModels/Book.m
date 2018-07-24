//
//  Book.m
//  BookTrader
//
//  Created by Connor Clancy on 7/17/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "Book.h"
#import <Parse/Parse.h>
@interface Book ()
@end

@implementation Book

@dynamic author, title, date, coverurl, userID, longitude, latitude, own, want, sell, trade, gift, location,user;
NSString *str_bsnNum;
NSDictionary *rawJson;
BOOL getInfo;


+ (nonnull NSString *)parseClassName {
    return @"Book";
}

- (void) setIsbn:(NSString *)str_bsn {
    str_bsnNum = str_bsn;
}


+ (void) addBookToDatabaseWithTitle:(NSString *)title withAuthor:(NSString *)author withCoverURL:(NSString *)coverURL withLatitude:(NSValue *)latitude withLongitude:(NSValue *)longitude withOwn:(BOOL)own withSell:(BOOL)sell withTrade:(BOOL)trade withGift:(BOOL)gift withUserID:(NSString *)userId withCompletion:(PFBooleanResultBlock)completion {
    Book *book = [Book new];
    book.title = title;
    book.author = author;
    book.coverurl = coverURL;
    book.longitude = longitude;
    book.latitude = latitude;
    book.own = own;
    book.sell = sell;
    book.trade = trade;
    book.gift = gift;
    book.userID = userId;
    
    [book saveInBackgroundWithBlock:completion];
}

@end
