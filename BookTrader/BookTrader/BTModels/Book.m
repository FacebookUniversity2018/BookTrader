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


+(void)addBookToDatabase:(NSString *)title withAuthor:(NSString *)author withDate:(NSString *)date withCover:(NSString *)coverurl
                //withUser:(NSString *)userID withSell:(BOOL)sell withTrade:(BOOL)trade withGift:(BOOL)gift withLongitude:(NSValue *)longitude withLatitude:(NSValue *)latitude withOwn:(BOOL)own
          withCompletion:(PFBooleanResultBlock)completion {
    
    Book *newBook = [Book new];
    newBook.title = title;
    newBook.author = author;
    newBook.date = date;
    newBook.coverurl = coverurl;
//    newBook.gift = gift;
//    newBook.sell = sell;
 //   newBook.trade = trade;
 //   newBook.own = own;
    //newBook.userID = userID;
   // newBook.longitude = longitude;
   // newBook.latitude = latitude;

    [newBook saveInBackgroundWithBlock: completion];

}

@end
