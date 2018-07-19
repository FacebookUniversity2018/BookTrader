//
//  BookDetailViewController.m
//  BookTrader
//
//  Created by Connor Clancy on 7/16/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "BookDetailViewController.h"
#import "Book.h"

@interface BookDetailViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *bookCover;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@end

@implementation BookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.book setIsbn:self.isbn];
    NSDictionary *currentBook = [Book fetchData:self.isbn];
    self.titleLabel.text = currentBook[@"title"];
    NSArray *authors = currentBook[@"authors"];
    self.authorLabel.text = authors[0];
    self.dateLabel.text = currentBook[@"publishedDate"];
    // Do any additional setup after loading the view.
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
