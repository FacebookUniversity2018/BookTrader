//
//  AddBookViewController.m
//  PostingBookDemo
//
//  Created by Connor Clancy on 7/20/18.
//  Copyright © 2018 connorclancy. All rights reserved.
//

#import "AddBookViewController.h"
#import "Book.h"

@interface AddBookViewController ()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) NSDictionary *bookInfo;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *author;
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
    NSURL *url = [NSURL URLWithString:url_request];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            self.bookInfo = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            self.bookInfo = self.bookInfo[@"items"][0][@"volumeInfo"];
            NSLog(@"%@", self.bookInfo[@"title"]);
            NSLog(@"%@", self.bookInfo[@"authors"][0]);
            self.title = self.bookInfo[@"title"];
            self.author = self.bookInfo[@"authors"][0];
            self.titleLabel.text = self.title;
            self.authorLabel.text = self.author;
            
        }
    }];
    [task resume];
}


- (IBAction)publishBook:(id)sender {
    [Book addBookToDatabaseWithTitle:self.title withAuthor:self.author withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"posted book");
        } else {
            NSLog(@"%@", error);
        }
    }];
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
