//
//  APIManager.m
//  PostingBookDemo
//
//  Created by Connor Clancy on 7/20/18.
//  Copyright © 2018 connorclancy. All rights reserved.
//

#import "APIManager.h"

@implementation APIManager




- (void) fetchData:(NSString *)isbn {
    NSString *url_body = @"https://www.googleapis.com/books/v1/volumes?q=isbn:";
    NSString *url_request = [NSString stringWithFormat:@"%@%@", url_body,
                             isbn];
    NSError *error;
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_request]];
    NSDictionary *rawJson = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
}
@end
