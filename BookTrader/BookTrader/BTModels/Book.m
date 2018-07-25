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

@dynamic author;
@dynamic title;
@dynamic date;
@dynamic coverurl;
@dynamic userID;
@dynamic longitude;
@dynamic latitude;
@dynamic own;
@dynamic want;
@dynamic sell;
@dynamic trade;
@dynamic gift;


//NSString *str_bsnNum;
//NSDictionary *rawJson;
//BOOL getInfo;


+ (nonnull NSString *)parseClassName {
    return @"Book";
}

//- (void) setIsbn:(NSString *)str_bsn {
//    NSString *str_bsnNum;
//    str_bsnNum = str_bsn;
//}



+ (void) addBookToDatabaseWithTitle:(NSString *)title author:(NSString *)author coverURL:(NSString *)coverURL
                           latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude own:(BOOL)own
                               sell:(BOOL)sell trade:(BOOL)trade gift:(BOOL)gift userID:(NSString *)userID
                         completion:(PFBooleanResultBlock)completion {
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
    book.userID = userID;
    [book saveInBackgroundWithBlock:completion];
}




@end
