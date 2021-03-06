//
//  MessagesHomeViewController.m
//  BookTrader
//
//  Created by Connor Clancy on 7/16/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "MessagesHomeViewController.h"
#import "MessagesHeaderCell.h"
#import "MessageCell.h"
#import <FBSDKMessengerShareKit/FBSDKMessengerShareKit.h>

@interface MessagesHomeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MessagesHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [FBSDKMessengerSharer openMessenger];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
    [FBSDKMessengerSharer openMessenger];
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

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MessageCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
    MessagesHeaderCell *headerCell = [self.tableView dequeueReusableCellWithIdentifier:@"MessagesHeader"];
    if (indexPath.row == 0) {
        return headerCell;
    } else {
        return cell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (IBAction)tappedBackButton:(id)sender {
    
    if ([self.navigationControl isEqualToString:@"navView"]) {
        [self performSegueWithIdentifier:@"messagesToNavSegue" sender:nil];
    } else if ([self.navigationControl isEqualToString:@"profileView"]) {
        [self performSegueWithIdentifier:@"messagesToProfileSegue" sender:nil];
    } else {
        NSLog(@"error in navigation control, assign a segue");
    }
}


@end
