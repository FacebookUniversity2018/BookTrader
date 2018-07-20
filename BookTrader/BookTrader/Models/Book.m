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
- (void)parseData;
@end

@implementation Book

@dynamic author, title, date, coverURL, str_bsnNum, rawJson;
BOOL getInfo;
BOOL sell;
BOOL trade;
BOOL gift;
BOOL buy;
BOOL wantTrade;
BOOL wantGift;
BOOL location;


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


+(void)addBookToDatabase:(NSString *)title withAuthor:(NSString *)author withDate:(NSString *)date withCover:(NSString *)coverURL withCompletion:(PFBooleanResultBlock _Nullable)completion {
    
    Book *newBook = [Book new];
    newBook.title = title;
    newBook.author = author;
    newBook.date = date;
    newBook.coverURL = coverURL;
  //  newBook.user = [PFUser currentUser];
    //newBook.overview = overview;

    [newBook saveInBackgroundWithBlock: completion];
    
}
@end
