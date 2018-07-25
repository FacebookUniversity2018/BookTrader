//
//  Book.h
//  BookTrader
//
//  Created by Connor Clancy on 7/17/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"
#import "User.h"

@interface Book : PFObject<PFSubclassing> 

@property (strong, nonatomic) User *user;

@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *coverurl;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;
@property (strong, nonatomic) NSString *userID;

@property (nonatomic) BOOL own;
@property (nonatomic) BOOL want;
@property (nonatomic) BOOL sell;
@property (nonatomic) BOOL trade;
@property (nonatomic) BOOL gift;

- (void) setIsbn:(NSString *)str_bsn;


+ (void) addBookToDatabaseWithTitle:(NSString *)title author:(NSString *)author coverURL:(NSString *)coverURL
                           latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude own:(BOOL)own
                               sell:(BOOL)sell trade:(BOOL)trade gift:(BOOL)gift userID:(NSString *)userID
                         completion:(PFBooleanResultBlock)completion;
@end
