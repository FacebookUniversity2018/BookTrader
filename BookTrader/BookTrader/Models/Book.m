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

@dynamic author;
@dynamic title;
@dynamic datePublished;
@dynamic coverURL;
NSDictionary *rawJson;
NSString *str_bsnNum;
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
        NSDictionary *images = [[NSDictionary alloc] initWithDictionary:volumeInfo[@"imageLinks"]];
        NSDictionary *res = @{@"title": volumeInfo[@"title"], @"authors": volumeInfo[@"authors"], @"publishedDate":volumeInfo[@"publishedDate"]};
        return res;

     //   coverUrl = images[@"small"];
    }
}



+(void)addBookToDatabase:(NSString *)title withAuthor:(NSString *)author withOverview:(NSString *)overview withCompletion:(PFBooleanResultBlock _Nullable)completion {
    Book *newBook = [Book new];
    newBook.title = title;
    newBook.author = author;
    //newBook.datePublished = datePublished;
    //newBook.overview = overview;

    [newBook saveInBackgroundWithBlock: completion];
    
}
@end
