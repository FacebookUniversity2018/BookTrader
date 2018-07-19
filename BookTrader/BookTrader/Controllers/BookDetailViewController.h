//
//  BookDetailViewController.h
//  BookTrader
//
//  Created by Connor Clancy on 7/16/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"

@interface BookDetailViewController : UIViewController

@property (strong, nonatomic) Book *book;
@property NSString *isbn;

@end
