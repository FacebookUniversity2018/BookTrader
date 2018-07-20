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
@property (strong, nonatomic) NSString *overview;
@property (strong, nonatomic) NSString *genre;
@property (nonatomic) BOOL sell;
@property (nonatomic) BOOL gift;
@property (nonatomic) BOOL trade;
@property (nonatomic) int location;
@property (strong, nonatomic) User *user;
<<<<<<< HEAD:BookTrader/BookTrader/BTModels/Book.h

=======
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;
>>>>>>> a2062f0a17fd4718b6f28e78e3e8a7d0b6cecef0:BookTrader/BookTrader/Models/Book.h

- (void) setIsbn:(NSString *)str_bsn;
+ (NSDictionary *) fetchData:(NSString *)isbn;
+ (NSDictionary *) parseData:(NSDictionary *)raw;

+(void) addBookToDatabase: (NSString * )title withAuthor:(NSString * )author withDate:(NSString *)date withCover:(NSString *)coverURL withSell:(BOOL)sell withTrade:(BOOL)trade withGift:(BOOL)gift withLatitude:(NSString *)latitude withLongitude:(NSString *)longitude withCompletion:(PFBooleanResultBlock _Nullable)completion;
@end
