//
//  APIManager.m
//  BookAPI
//
//  Created by Claudia Haddad on 7/17/18.
//  Copyright © 2018 Claudia Haddad. All rights reserved.
//

#import "APIManager.h"

@implementation APIManager {

NSString  *coverUrl;
NSString  *bookTitle;
NSString *author;
NSString *datePublished;
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
        bookTitle = volumeInfo[@"title"];
        author = volumeInfo[@"authors"];
        datePublished= volumeInfo[@"publishedDate"];
       // coverUrl = thumbnails[@"thumbnail"];
    }
}

- (BOOL) getInfo {
    return getInfo;
}

- (NSString *) getCover {
    return coverUrl;
}

- (NSString *) getTitle {
    return bookTitle;
}

- (NSString *) getBookIsbn {
    return str_bsnNum;
}
@end
