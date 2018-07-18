//
//  User.m
//  BookTrader
//
//  Created by Connor Clancy on 7/17/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "User.h"
#import <Parse/Parse.h>

@implementation User

@dynamic userId;
@dynamic firstName;
@dynamic lastName;
@dynamic bio;
@dynamic profilePicture;

+ (nonnull NSString *)parseClassName {
    return @"User";
}

+(void)addUserToDatabase:(NSString *)userId withFirstName:(NSString *)firstName withLastName:(NSString *)lastName withBio:(NSString *)bio withProfilePicture:(PFFile *)profilePicture withCompletion:(PFBooleanResultBlock _Nullable)completion {
    User *newUser = [User new];
    newUser.userId = userId;
    newUser.firstName = firstName;
    newUser.lastName = lastName;
    newUser.bio = bio;
    newUser.profilePicture = profilePicture;
    
    [newUser saveInBackgroundWithBlock:completion];
    
};

@end
