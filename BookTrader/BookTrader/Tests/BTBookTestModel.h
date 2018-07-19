//
//  BTBookTestModel.h
//  BookTrader
//
//  Created by Connor Clancy on 7/19/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"
#import "BTUserTestModel.h"

@interface BTBookTestModel : PFObject<PFSubclassing>

@property (strong, nonatomic) NSString *bookId;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *overview;
@property (strong, nonatomic) NSString *genre;
@property (nonatomic) BOOL sell;
@property (nonatomic) BOOL gift;
@property (nonatomic) BOOL trade;
@property (nonatomic) int location;
@property (strong, nonatomic) BTUserTestModel *user;

+ (void) BTAddBookToDatabase:(NSString *)bookId withTitle:(NSString *)title withAuthor:(NSString *)author
                withOverview:(NSString *)overview withGenre:(NSString *)genre canSell:(BOOL)sell canGift:(BOOL)gift
                    canTrade:(BOOL)trade withLocation:(int)location withUser:(BTUserTestModel *)user withCompletion:(PFBooleanResultBlock _Nullable)completion;

@end
