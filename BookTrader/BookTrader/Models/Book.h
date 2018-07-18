//
//  Book.h
//  BookTrader
//
//  Created by Connor Clancy on 7/17/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"

@interface Book : PFObject<PFSubclassing>

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *overview;

+(void)addBookToDatabase:(NSString * _Nullable )title withAuthor:(NSString * _Nullable)author withOverview:(NSString * _Nullable)overview withCompletion: (PFBooleanResultBlock  _Nullable)completion;
@end
