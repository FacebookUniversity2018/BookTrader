//
//  AddBookDetailsViewController.m
//  BookTrader
//
//  Created by Connor Clancy on 7/16/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "AddBookDetailsViewController.h"
#import "Book.h"

@interface AddBookDetailsViewController ()
//UI
@property (strong, nonatomic) IBOutlet UISegmentedControl *bookControl;
@property (strong, nonatomic) IBOutlet UIImageView *bookCover;
@property (strong, nonatomic) IBOutlet UIView *haveBookView;
@property (strong, nonatomic) IBOutlet UIView *wantBookView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIButton *sellButton;
@property (strong, nonatomic) IBOutlet UIButton *tradeButton;
@property (strong, nonatomic) IBOutlet UIButton *giftButton;
@property (strong, nonatomic) IBOutlet UIButton *buyButton;
@property (strong, nonatomic) IBOutlet UIButton *wantTradeButton;
@property (strong, nonatomic) IBOutlet UIButton *wantGiftButton;
@property (strong, nonatomic) IBOutlet UIButton *locationButton;
//variables
@property (strong, nonatomic) NSString *bookURL;
//post
//@property (strong, nonatomic) NSURL *url;
//@property (strong, nonatomic) NSString *author;
//@property (strong, nonatomic) NSString *date;
//@property (strong, nonatomic) NSString *title;

@end

@implementation AddBookDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.book setIsbn:self.isbn];
    NSDictionary *currentBook = [Book fetchData:self.isbn];
    self.titleLabel.text = currentBook[@"title"];
    self.title = currentBook[@"title"];
    NSArray *authors = currentBook[@"authors"];
    self.authorLabel.text = authors[0];
    self.dateLabel.text = currentBook[@"publishedDate"];
    NSDictionary *images = currentBook[@"imageLinks"];
    self.bookURL = images[@"thumbnail"];

    NSURL *url = [NSURL URLWithString:self.
                bookURL];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    self.bookCover.image = [UIImage imageWithData:imageData];
}

- (IBAction)onPublish:(id)sender {
    
    NSLog(@"%@", self.title);

    [Book addBookToDatabase:@"thisBook" withAuthor:nil withDate:nil withCover:nil withSell:nil withTrade:nil withGift:nil withLongitude:nil withLatitude:nil withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        return;
    }];
    
[self dismissViewControllerAnimated:true completion:nil];
    NSLog(@"published!");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)showNewView:(id)sender {
//segmented control to switch container views
    if(self.bookControl.selectedSegmentIndex==0){
        [UIView animateWithDuration:(0.5) animations:^{
            self.haveBookView.alpha = 1;
            self.wantBookView.alpha = 0;
        }];
    } else {

        [UIView animateWithDuration:(0.5) animations:^{
            self.haveBookView.alpha = 0;
            self.wantBookView.alpha = 1;     }];
    }
}



// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 //   if ([[segue identifier] isEqualToString:@"bookAddDetailsToBarcodeSegue"]) {
        
   // } else {
  //      NSLog([segue identifier]);
   // }
//}


- (IBAction)sellButton:(id)sender {
    if (!self.sell) {
    self.sell = true;
    [self.sellButton setImage:[UIImage imageNamed:@"iconmonstr-checkbox-4-240.png"] forState:UIControlStateNormal];
    } else if (self.sell) {
    self.sell = false;
    [self.sellButton setImage:[UIImage imageNamed:@"iconmonstr-checkbox-6-240.png"] forState:UIControlStateNormal];
}
}

- (IBAction)tradeButton:(id)sender {
    if (!self.trade) {
        self.trade = true;
        [self.tradeButton setImage:[UIImage imageNamed:@"iconmonstr-checkbox-4-240.png"] forState:UIControlStateNormal];
    } else if (self.trade) {
        self.trade = false;
        [self.tradeButton setImage:[UIImage imageNamed:@"iconmonstr-checkbox-6-240.png"] forState:UIControlStateNormal];
    }
}
- (IBAction)giftButton:(id)sender {
    if (!self.gift) {
        self.gift = true;
        [self.giftButton setImage:[UIImage imageNamed:@"iconmonstr-checkbox-4-240.png"] forState:UIControlStateNormal];
    } else if (self.gift) {
        self.gift = false;
        [self.giftButton setImage:[UIImage imageNamed:@"iconmonstr-checkbox-6-240.png"] forState:UIControlStateNormal];
    }
}
- (IBAction)locationButton:(id)sender {
    if (!self.location) {
        self.location = true;
        [self.locationButton setImage:[UIImage imageNamed:@"iconmonstr-checkbox-4-240.png"] forState:UIControlStateNormal];
    } else if (self.location) {
        self.location = false;
        [self.locationButton setImage:[UIImage imageNamed:@"iconmonstr-checkbox-6-240.png"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)buyButton:(id)sender {
    if (!self.buy) {
        self.buy = true;
        [self.buyButton setImage:[UIImage imageNamed:@"iconmonstr-checkbox-4-240.png"] forState:UIControlStateNormal];
    } else if (self.gift) {
        self.buy = false;
        [self.buyButton setImage:[UIImage imageNamed:@"iconmonstr-checkbox-6-240.png"] forState:UIControlStateNormal];
    }
}
- (IBAction)wantTradeButton:(id)sender {
    if (!self.wantTrade) {
        self.wantTrade = true;
        [self.wantTradeButton setImage:[UIImage imageNamed:@"iconmonstr-checkbox-4-240.png"] forState:UIControlStateNormal];
    } else if (self.wantTrade) {
        self.wantTrade = false;
        [self.wantTradeButton setImage:[UIImage imageNamed:@"iconmonstr-checkbox-6-240.png"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)wantGiftButton:(id)sender {

    if (!self.wantGift) {
        self.wantGift= true;
        [self.wantGiftButton setImage:[UIImage imageNamed:@"iconmonstr-checkbox-4-240.png"] forState:UIControlStateNormal];
    } else if (self.wantGift) {
        self.wantGift = false;
        [self.wantGiftButton setImage:[UIImage imageNamed:@"iconmonstr-checkbox-6-240.png"] forState:UIControlStateNormal];
    }
}


@end