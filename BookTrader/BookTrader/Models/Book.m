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
@dynamic title;
@dynamic author;
@dynamic overview;

+ (nonnull NSString *)parseClassName {
    return @"Book";
}

self.title = dictionary[
self.author =


+(void)addBookToDatabase:(NSString *)title withAuthor:(NSString *)author withOverview:(NSString *)overview withCompletion:(PFBooleanResultBlock _Nullable)completion {
    Book *newBook = [Book new];
    newBook.title = title;
    newBook.author = author;
    newBook.overview = overview;

    [newBook saveInBackgroundWithBlock: completion];
    
}
@end
