//
//  Book.h
//  BookTrader
//
//  Created by Connor Clancy on 7/17/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"

@interface Book : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *overview;

+(void)addBookToDatabase:(NSString *)title withAuthor:(NSString *)author withOverview:(NSString *overview) withCompletion:(PFBooleanResultBlock _Nullable)completion;
@end
