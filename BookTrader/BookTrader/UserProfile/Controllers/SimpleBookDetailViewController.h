//
//  SimpleBookDetailViewController.h
//  BookTrader
//
//  Created by Claudia Haddad on 7/17/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"

@interface SimpleBookDetailViewController : UIViewController

@property NSString *isbn;
@property (strong, nonatomic) Book *book;

@end
