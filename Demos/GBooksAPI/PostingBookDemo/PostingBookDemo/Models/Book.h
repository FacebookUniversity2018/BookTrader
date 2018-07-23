//
//  Book.h
//  PostingBookDemo
//
//  Created by Connor Clancy on 7/20/18.
//  Copyright © 2018 connorclancy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"

@interface Book : PFObject<PFSubclassing>
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *author;

+ (void)addBookToDatabaseWithTitle:(NSString *)title withAuthor:(NSString *)author withCompletion:(PFBooleanResultBlock _Nullable)completion;

@end
