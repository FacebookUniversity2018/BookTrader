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
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSString *str_bsnNum;
@property (strong, nonatomic) NSDictionary *rawJson;
@property CGFloat *latitude;
@property CGFloat *longitude;

- (void) setIsbn:(NSString *)str_bsn;
+ (NSDictionary *) fetchData:(NSString *)isbn;
+ (NSDictionary *) parseData:(NSDictionary *)raw;

+(void) addBookToDatabase: (NSString * )title withAuthor:(NSString * )author withDate:(NSString *)date withCover:(NSString *)coverURL withCompletion:(PFBooleanResultBlock _Nullable)completion;
@end
