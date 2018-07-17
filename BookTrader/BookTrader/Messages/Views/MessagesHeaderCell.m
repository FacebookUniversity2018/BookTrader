//
//  MessagesHeaderCell.m
//  BookTrader
//
//  Created by Connor Clancy on 7/16/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "MessagesHeaderCell.h"
@interface MessagesHeaderCell ()
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@end

@implementation MessagesHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
