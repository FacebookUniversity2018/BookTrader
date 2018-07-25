//
//  APIManager.h
//  BookAPI
//
//  Created by Claudia Haddad on 7/17/18.
//  Copyright © 2018 Claudia Haddad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIManager : NSObject {

    NSString *str_bsnNum;
}


- (void) setIsbn:(NSString *)str_bsn;

- (BOOL) getInfo;
- (NSString *) getCover;
- (NSString *) getTitle;
- (NSString *) getBookIsbn;
+ (void) fetchData;

@end
