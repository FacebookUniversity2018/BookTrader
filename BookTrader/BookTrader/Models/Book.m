//
//  Book.m
//  BookTrader
//
//  Created by Connor Clancy on 7/17/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "Book.h"
#import <Parse/Parse.h>


@implementation Book

@dynamic author;
@dynamic title;
@dynamic datePublished;
NSDictionary *rawJson;
NSString *str_bsnNum;
BOOL getInfo;

+ (nonnull NSString *)parseClassName {
    return @"Book";
}

<<<<<<< HEAD
//self.title = dictionary[
//self.author =
=======

- (void) setIsbn:(NSString *)str_bsn {
    str_bsnNum = str_bsn;
    [self fetchData];
}

- (void) fetchData {
    NSString *url_body = @"https://www.googleapis.com/books/v1/volumes?q=isbn:";
    NSString *url_request = [NSString stringWithFormat:@"%@%@", url_body,
                             str_bsnNum];
    NSError *error;
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_request]];
    rawJson = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    [self parseData: rawJson];
}

- (void) parseData:(NSDictionary *)raw {
    NSArray *rawItem = [[NSArray alloc] initWithArray:raw[@"items"]];
    if ([rawItem count] == 0) {
        getInfo = false;
    } else {
        getInfo = true;
        NSDictionary *item = [[NSDictionary alloc] initWithDictionary:rawItem[0]];
        NSDictionary *volumeInfo = [[NSDictionary alloc] initWithDictionary:item[@"volumeInfo"]];
        NSDictionary *thumbnails = [[NSDictionary alloc] initWithDictionary:volumeInfo[@"imageLinks"]];
        self.title = volumeInfo[@"title"];
        self.author = volumeInfo[@"authors"];
        self.datePublished= volumeInfo[@"publishedDate"];
     //   coverUrl = thumbnails[@"thumbnail"];
    }
}

>>>>>>> d6be8b637bb2997242cd623f9b1f5569dcc23a3a


+(void)addBookToDatabase:(NSString *)title withAuthor:(NSString *)author withOverview:(NSString *)overview withCompletion:(PFBooleanResultBlock _Nullable)completion {
    Book *newBook = [Book new];
    newBook.title = title;
    newBook.author = author;
    //newBook.overview = overview;

    [newBook saveInBackgroundWithBlock: completion];
    
}
@end
