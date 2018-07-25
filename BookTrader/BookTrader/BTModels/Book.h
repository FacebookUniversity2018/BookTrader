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

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *coverurl;

@property (strong, nonatomic) User *user;


@property (strong, nonatomic) NSValue *latitude;
@property (strong, nonatomic) NSValue *longitude;
@property (strong, nonatomic) NSString *userID;

@property (nonatomic) BOOL own;
@property (nonatomic) BOOL want;
@property (nonatomic) BOOL sell;
@property (nonatomic) BOOL trade;
@property (nonatomic) BOOL gift;
@property (nonatomic) BOOL location;

- (void) setIsbn:(NSString *)str_bsn;


+ (void) addBookToDatabaseWithTitle:(NSString *)title withAuthor:(NSString *)author withCoverURL:(NSString *)coverURL withLatitude:(NSValue *)latitude withLongitude:(NSValue *)longitude withOwn:(BOOL)own withSell:(BOOL)sell withTrade:(BOOL)trade withGift:(BOOL)gift withUserID:(NSString *)userId
                     withCompletion:(PFBooleanResultBlock)completion;
@end
