//
//  User.h
//  BookTrader
//
//  Created by Connor Clancy on 7/17/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface User : PFObject<PFSubclassing>

@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *bio;
@property (strong, nonatomic) NSString *profilePicture;
@property (strong, nonatomic) NSMutableArray *booksHave;
@property (strong, nonatomic) NSMutableArray *booksWant;

+(void)addUserToDatabase:(NSString *)userId withFirstName:(NSString *)firstName withLastName:(NSString *)lastName withBio:(NSString *)bio withProfilePicture:(NSString *)profilePicture withBooks:(NSMutableArray *)booksHave withWantBooks:(NSMutableArray *)booksWant withCompletion:(PFBooleanResultBlock)completion;

+ (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image;
+ (User *) initUserWithDictionary: (NSDictionary *) dictionary;

- (void)addToBooksWant:(NSString *)objectId;
- (void)removeFromBooksWant:(NSString *)objectId;

@end
