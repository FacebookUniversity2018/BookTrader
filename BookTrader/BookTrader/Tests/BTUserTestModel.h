//
//  BTUserTestModel.h
//  BookTrader
//
//  Created by Connor Clancy on 7/19/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Parse/Parse.h"

@interface BTUserTestModel : PFObject<PFSubclassing>
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *bio;
@property (strong, nonatomic) PFFile *imageFile;
@property (strong, nonatomic) NSArray *booksHave;
@property (strong, nonatomic) NSArray *booksWant;
@property (strong, nonatomic) BTUserTestModel *queriedUser;

+ (void) BTAddUserToDatabase:(NSString *)userId withFirstName:(NSString *)firstName withLastName:(NSString *)lastName
                    withBio:(NSString *)bio withImage:(PFFile *)imageFile withMyBooksArray:(NSArray *)booksHave withWantBooksArray:(NSArray *)booksWant withCompletion:(PFBooleanResultBlock _Nullable)completion;

@end
