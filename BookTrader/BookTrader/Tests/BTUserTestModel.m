//
//  BTUserTestModel.m
//  BookTrader
//
//  Created by Connor Clancy on 7/19/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "BTUserTestModel.h"

@implementation BTUserTestModel
@dynamic userId;
@dynamic firstName;
@dynamic lastName;
@dynamic bio;
@dynamic imageFile;
@dynamic booksHave;
@dynamic booksWant;

+ (nonnull NSString *)parseClassName {
    return @"UserTest";
}

+(void) BTAddUserToDatabase:(NSString *)userId withFirstName:(NSString *)firstName withLastName:(NSString *)lastName
                    withBio:(NSString *)bio withImage:(PFFile *)imageFile withMyBooksArray:(NSArray *)booksHave withWantBooksArray:(NSArray *)booksWant withCompletion:(PFBooleanResultBlock _Nullable)completion {
    BTUserTestModel *user = [BTUserTestModel new];
    user.userId = userId;
    user.firstName = firstName;
    user.lastName = lastName;
    user.bio = bio;
    user.imageFile = imageFile;
    user.booksHave = booksHave;
    user.booksWant = booksWant;
    
    [user saveInBackgroundWithBlock: completion];
};

+ (BTUserTestModel *) BTGetUserWithUserId:(NSString *)userId {
    
    return [BTUserTestModel new];
};
@end
