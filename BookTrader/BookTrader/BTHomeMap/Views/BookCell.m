//
//  BookCell.m
//  BookTrader
//
//  Created by Connor Clancy on 7/17/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "BookCell.h"
#import "UIImageView+AFNetworking.h"


@interface BookCell ()
@property (strong, nonatomic) IBOutlet UIImageView *bookCoverImage;

@end

@implementation BookCell

- (void)setBook:(Book *)book {
    _book = book;
    NSURL *url = [NSURL URLWithString:book.coverurl];
    [self.bookCoverImage setImageWithURL:url];
    
}
@end
