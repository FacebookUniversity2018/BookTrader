//
//  AddBookDetailsViewController.m
//  BookTrader
//
//  Created by Connor Clancy on 7/16/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "AddBookDetailsViewController.h"

@interface AddBookDetailsViewController ()
@property (strong, nonatomic) IBOutlet UISegmentedControl *bookControl;
@property (strong, nonatomic) IBOutlet UIImageView *bookCover;
@property (strong, nonatomic) IBOutlet UILabel *genreLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIView *haveBookView;
@property (strong, nonatomic) IBOutlet UIView *wantBookView;

// property NSString *title
// property NSString *created date
// property NSString *author
// property UIImage *bookCover

@end

@implementation AddBookDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // NSDictionary *bookObj (your rawJson) = [GBooksAPI bookObjectFromIsbn:self.isbn]
    // [GBooksAPI bookObjectFromIsbn: ] write in the the + GBooksAPI directory and it will do what your
    // "fetchData" function is doing right now
    // self.title = bookObj.title
    // self.created_date = bookObj.createdDate
    // self.author = bookObj.author
    // self.bookCover = [That one AFNetworking function that turns a URL into an Image]
    // then use these variables to set up all of the views
    
    // then in the publish button use the parsePostFunction before we leave this page
    // then we can reload everything in the other views and the book will be posted
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)showNewView:(id)sender {
//}

    
    
//segmented control to switch container views
//- (IBAction)showView:(id)sender {
    if(self.bookControl.selectedSegmentIndex==0){
        [UIView animateWithDuration:(0.5) animations:^{
            self.haveBookView.alpha = 1;
            self.wantBookView.alpha = 0;
        }];
    } else {
            //if (self.bookControl.selectedSegmentIndex==1){
        [UIView animateWithDuration:(0.5) animations:^{
            self.haveBookView.alpha = 0;
            self.wantBookView.alpha = 1;     }];
}
         }


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sellButton:(id)sender {
}
@end
