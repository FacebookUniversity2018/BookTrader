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
@property (strong, nonatomic) NSDictionary *currentBook;
@property (strong, nonatomic) NSDictionary *images;
//post
@property (strong, nonatomic) NSString *bookURL;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *btitle;
@property (strong, nonatomic) NSValue *lat;
@property (strong, nonatomic) NSValue *lon;

//buttons
@property (nonatomic, assign) BOOL sell;
@property (nonatomic, assign) BOOL trade;
@property (nonatomic, assign) BOOL gift;
@property (nonatomic, assign) BOOL location;
@property (nonatomic, assign) BOOL own;



@end

@implementation AddBookDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchData:self.isbn];
}
    
- (void) fetchData:(NSString *)isbn {
    NSString *url_body = @"https://www.googleapis.com/books/v1/volumes?q=isbn:";
    NSString *url_request = [NSString stringWithFormat:@"%@%@", url_body, isbn];
    NSURL *url = [NSURL URLWithString:url_request];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30.0];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            self.currentBook = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            self.currentBook = self.currentBook[@"items"][0][@"volumeInfo"];
            NSLog(@"title is");
            NSLog(@"%@", self.currentBook[@"title"]);
            NSLog(@"%@", self.currentBook[@"authors"][0]);
            self.btitle = self.currentBook[@"title"];
            self.author = self.currentBook[@"authors"][0];
            self.date = self.currentBook[@"publishedDate"];
            self.images = self.currentBook[@"imageLinks"];
            self.bookURL = self.images[@"thumbnail"];
            
            NSURL *url = [NSURL URLWithString:self.
                          bookURL];
            NSData *imageData = [NSData dataWithContentsOfURL:url];
            //set UI
            self.titleLabel.text = self.btitle;
            self.authorLabel.text = self.author;
            self.dateLabel.text = self.date;
            self.bookCover.image = [UIImage imageWithData:imageData];
        }
    }];
    [task resume];
}

- (IBAction)onPublish:(id)sender {
    
    self.own = true;
    //latitude
    //longitude
    [Book addBookToDatabase:self.btitle withAuthor:self.author withDate: self.date withCover:self.bookURL
                   //withSell:nil withTrade:nil withGift:nil withLongitude:nil withLatitude:nil withOwn:nil
             withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
                 if (succeeded) {
                     NSLog(@"posted book");
                 } else {
                     NSLog(@"%@", error);
                 }
             }];

[self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)onRequest:(id)sender {
    self.own = false;
    
  /*  [Book addBookToDatabase:nil withAuthor: withDate: withCover: withSell: withTrade:nil withGift:nil withLongitude:nil withLatitude:nil withOwn:own
             withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
             }];
   */
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

- (IBAction)useCurrentLocation:(id)sender {
    
}

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
        //TODO:set lat and long here
    } else if (self.location) {
        self.location = false;
        [self.locationButton setImage:[UIImage imageNamed:@"iconmonstr-checkbox-6-240.png"] forState:UIControlStateNormal];
    }
    
}

/*
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
*/

@end
