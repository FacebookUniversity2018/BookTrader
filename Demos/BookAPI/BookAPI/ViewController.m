//
//  ViewController.m
//  BookAPI
//
//  Created by Claudia Haddad on 7/17/18.
//  Copyright © 2018 Claudia Haddad. All rights reserved.
//

#import "ViewController.h"
#import "APIManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [APIManager fetchData];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
