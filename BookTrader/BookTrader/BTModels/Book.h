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
@property (strong, nonatomic) NSString *coverURL;
//@property (strong, nonatomic) NSString *overview;

@property (strong, nonatomic) User *user;


@property (strong, nonatomic) NSValue *latitude;
@property (strong, nonatomic) NSValue *longitude;
@property (strong, nonatomic) NSString *userID;

@property (nonatomic, assign) BOOL own;
@property (nonatomic, assign) BOOL want;
@property (nonatomic, assign) BOOL sell;
@property (nonatomic, assign) BOOL trade;
@property (nonatomic, assign) BOOL gift;
@property (nonatomic, assign) BOOL location;

- (void) setIsbn:(NSString *)str_bsn;

+(void)addBookToDatabase:(NSString *)title withAuthor:(NSString *)author withDate:(NSString *)date withCover:(NSString *)coverURL withSell:(BOOL)sell withTrade:(BOOL)trade withGift:(BOOL)gift withLongitude:(NSValue *)longitude withLatitude:(NSValue *)latitude withOwn:own withCompletion:(PFBooleanResultBlock)completion;

+ (NSDictionary *) fetchData:(NSString *)isbn;
+ (NSDictionary *) parseData:(NSDictionary *)raw;

@end
