//
//  ProfileBookCell.m
//  BookTrader
//
//  Created by Connor Clancy on 7/24/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "ProfileBookCell.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileBookCell ()
@property (strong, nonatomic) IBOutlet UIImageView *coverImageView;

@end

@implementation ProfileBookCell

- (void)setBook:(Book *)book {
    _book = book;
    NSURL *url = [NSURL URLWithString:book.coverurl];
    [self.coverImageView setImageWithURL:url];
    
}

@end
