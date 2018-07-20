//
//  User.h
//  BookTrader
//
//  Created by Connor Clancy on 7/17/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@class User;

@protocol UserDelegate

- (void) getUser: (User *) user withID: (NSString *) id;

@end

@interface User : PFObject<PFSubclassing>

@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *bio;
@property (strong, nonatomic) PFFile *profilePicture;
@property (strong, nonatomic) NSArray *booksHave;
@property (strong, nonatomic) NSArray *booksWant;

+(void)addUserToDatabase:(NSString *)userId withFirstName:(NSString *)firstName withLastName:(NSString *)lastName withBio:(NSString *)bio withProfilePicture:(PFFile *)profilePicture withCompletion:(PFBooleanResultBlock)completion;

@end
