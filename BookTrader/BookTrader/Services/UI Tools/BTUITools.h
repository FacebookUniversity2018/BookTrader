//
//  BTUITools.h
//  BookTrader
//
//  Created by Connor Clancy on 7/16/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface BTUITools : NSObject

+ (UILabel *)BTCreateLabel:(NSString *)text withFont:(NSString *)font withFontSize:(CGFloat)size withColor:(UIColor *)color;

@end
