//
//  Book.m
//  PostingBookDemo
//
//  Created by Connor Clancy on 7/20/18.
//  Copyright © 2018 connorclancy. All rights reserved.
//

#import "Book.h"
#import <Parse/Parse.h>

@implementation Book

@dynamic title;
@dynamic author;

+ (nonnull NSString *)parseClassName {
    return @"DemoBookAdd";
}

+ (void)addBookToDatabaseWithTitle:(NSString *)title withAuthor:(NSString *)author withCompletion:(PFBooleanResultBlock _Nullable)completion {
    Book *book = [Book new];
    book.title = title;
    book.author = author;
    [book saveInBackgroundWithBlock:completion];
}
@end
