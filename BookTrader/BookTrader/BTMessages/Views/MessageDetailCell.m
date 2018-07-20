//
//  MessageDetailCell.m
//  BookTrader
//
//  Created by Connor Clancy on 7/16/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "MessageDetailCell.h"
@interface MessageDetailCell()
@property (strong, nonatomic) IBOutlet UILabel *messageLabel;
@end

@implementation MessageDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bubbleView.layer.cornerRadius = 16;
    self.bubbleView.clipsToBounds = true;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
