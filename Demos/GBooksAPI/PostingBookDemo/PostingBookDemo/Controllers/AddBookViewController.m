//
//  AddBookViewController.m
//  PostingBookDemo
//
//  Created by Connor Clancy on 7/20/18.
//  Copyright © 2018 connorclancy. All rights reserved.
//

#import "AddBookViewController.h"

@interface AddBookViewController ()
@property (strong, nonatomic) NSDictionary *bookInfo;
@end

@implementation AddBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchData:self.isbn];
}

- (void) fetchData:(NSString *)isbn {
    NSString *url_body = @"https://www.googleapis.com/books/v1/volumes?q=isbn:";
    NSString *url_request = [NSString stringWithFormat:@"%@%@", url_body,
                             isbn];
    NSError *error;
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_request]];
    NSDictionary *bookInfo = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSLog(@"%@", bookInfo);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
