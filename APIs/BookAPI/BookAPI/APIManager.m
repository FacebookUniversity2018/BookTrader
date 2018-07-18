//
//  APIManager.m
//  BookAPI
//
//  Created by Claudia Haddad on 7/17/18.
//  Copyright © 2018 Claudia Haddad. All rights reserved.
//

#import "APIManager.h"

@implementation APIManager {

NSString  *str_coverUrl;
NSString  *str_bookTitle;
NSDictionary *rawJson;
BOOL getInfo;
}

- (void) setIsbn:(NSString *)str_bsn {
    str_bsnNum = str_bsn;
    [self fetchData];
}

- (void) fetchData {
    NSString *url_body = @"https://www.googleapis.com/books/v1/volumes?q=isbn:";
    NSString *url_request = [NSString stringWithFormat:@"%@%@", url_body,
                             str_bsnNum];
    NSError *error;
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_request]];
    rawJson = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    [self parseData: rawJson];
}

- (void) parseData:(NSDictionary *)raw {
    NSArray *rawItem = [[NSArray alloc] initWithArray:raw[@"items"]];
    if ([rawItem count] == 0) {
        getInfo = false;
    } else {
        getInfo = true;
        NSDictionary *item = [[NSDictionary alloc] initWithDictionary:rawItem[0]];
        NSDictionary *volumeInfo = [[NSDictionary alloc] initWithDictionary:item[@"volumeInfo"]];
        NSDictionary *thumbnails = [[NSDictionary alloc] initWithDictionary:volumeInfo[@"imageLinks"]];
        str_bookTitle = volumeInfo[@"title"];
        str_coverUrl = thumbnails[@"thumbnail"];
    }
}

- (BOOL) getInfo {
    return getInfo;
}

- (NSString *) getCover {
    return str_coverUrl;
}

- (NSString *) getTitle {
    return str_bookTitle;
}

- (NSString *) getBookIsbn {
    return str_bsnNum;
}
@end
