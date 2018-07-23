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

@dynamic author, title, date, coverURL, userID, longitude, latitude, own, want, sell, trade, gift, location,user;
NSString *str_bsnNum;
NSDictionary *rawJson;
BOOL getInfo;


+ (nonnull NSString *)parseClassName {
    return @"Book";
}

- (void) setIsbn:(NSString *)str_bsn {
    str_bsnNum = str_bsn;
}

+ (NSDictionary *) fetchData:(NSString *)isbn {
    NSString *url_body = @"https://www.googleapis.com/books/v1/volumes?q=isbn:";
    NSString *url_request = [NSString stringWithFormat:@"%@%@", url_body,
                             isbn];
    NSError *error;
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_request]];
    rawJson = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    return [self parseData:rawJson];
}

+ (NSDictionary *) parseData:(NSDictionary *)raw {
    NSArray *rawItem = [[NSArray alloc] initWithArray:raw[@"items"]];
    if ([rawItem count] == 0) {
        getInfo = false;
        return [NSDictionary new];
    } else {
        getInfo = true;
        NSDictionary *item = [[NSDictionary alloc] initWithDictionary:rawItem[0]];
        NSDictionary *volumeInfo = [[NSDictionary alloc] initWithDictionary:item[@"volumeInfo"]];
        NSDictionary *res = @{@"title": volumeInfo[@"title"], @"authors": volumeInfo[@"authors"], @"publishedDate":volumeInfo[@"publishedDate"], @"imageLinks": volumeInfo[@"imageLinks"]};
        return res;
    }
}


+(void)addBookToDatabase:(NSString *)title withAuthor:(NSString *)author withDate:(NSString *)date withCover:(NSString *)coverURL withUser:(NSString *)userID withSell:(BOOL)sell withTrade:(BOOL)trade withGift:(BOOL)gift withLongitude:(NSValue *)longitude withLatitude:(NSValue *)latitude withOwn:(BOOL)own withCompletion:(PFBooleanResultBlock)completion {
    
    Book *newBook = [Book new];
    newBook.title = title;
    newBook.author = author;
    newBook.date = date;
    newBook.coverURL = coverURL;
    newBook.gift = false;
    newBook.sell = false;
    newBook.trade = false;
    newBook.own = own;
    newBook.userID = @"claudia"; 
    newBook.longitude = longitude;
    newBook.latitude = latitude;

    [newBook saveInBackgroundWithBlock: completion];
    
    
}
@end
