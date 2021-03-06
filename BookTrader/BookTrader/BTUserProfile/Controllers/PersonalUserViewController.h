//
//  PersonalUserViewController.h
//  BookTrader
//
//  Created by Connor Clancy on 7/16/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface PersonalUserViewController : UIViewController
@property (strong, nonatomic) NSArray *myBooks;
@property (strong, nonatomic) User *currentUser;
@end
