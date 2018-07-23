//
//  BarcodeAddViewController.m
//  BookTrader
//
//  Created by Connor Clancy on 7/16/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "BarcodeAddViewController.h"
#import "AddBookDetailsViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface BarcodeAddViewController () <AVCaptureMetadataOutputObjectsDelegate>
@property (strong, nonatomic) IBOutlet UIView *previewView;
@property (strong, nonatomic) AVCaptureSession *captureSession;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic) BOOL capturing;
@property (strong, nonatomic) NSString *isbn;
@property (strong, nonatomic) NSDictionary *currentBook;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *coverurl;
@property (strong, nonatomic) NSDictionary *images;

@end

@implementation BarcodeAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.captureSession = nil;
    self.capturing = NO;
    NSError *error;
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    self.captureSession = [AVCaptureSession new];
    [self.captureSession addInput:input];
    AVCaptureMetadataOutput *captureMetadataOutput = [AVCaptureMetadataOutput new];
    [self.captureSession addOutput:captureMetadataOutput];
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeEAN13Code]];
    self.videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    [self.videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.videoPreviewLayer setFrame:self.previewView.layer.bounds];
    [self.previewView.layer addSublayer:self.videoPreviewLayer];
    [self.captureSession startRunning];
}

-(void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeEAN13Code]) {
            self.isbn = [metadataObj stringValue];
            [self performSelectorOnMainThread:@selector(stopReading) withObject:[metadataObj stringValue] waitUntilDone:NO];
        }
    }
}

-(void)stopReading {
    [self.captureSession stopRunning];
    self.captureSession = nil;
    [self.videoPreviewLayer removeFromSuperlayer];
    [self fetchData:self.isbn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
    if ([[segue identifier] isEqualToString:@"barcodeToDetailsSegue"]) {
    AddBookDetailsViewController *vc = [segue destinationViewController];
    vc.isbn = self.isbn;
    vc.title = self.title;
    vc.author = self.author;
    vc.date = self.date;
    vc.coverurl = self.coverurl;
      //  bookDetailsViewController.currentLocation = self.currentLocation;
    } else if ([[segue identifier] isEqualToString:@"barcodeAddToHomeSegue"]) {
        
    } else {
        NSLog([segue identifier]);
   }
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
            self.currentBook = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            self.currentBook = self.currentBook[@"items"][0][@"volumeInfo"];
            NSLog(@"%@", self.currentBook[@"title"]);
            NSLog(@"%@", self.currentBook[@"authors"][0]);
            self.title= self.currentBook[@"title"];
            self.author = self.currentBook[@"authors"][0];
            self.date = self.currentBook[@"publishedDate"];
            self.images = self.currentBook[@"imageLinks"];
            self.coverurl = self.images[@"thumbnail"];
            NSLog(@"This is the title before the segue %@", self.title);
            NSLog(@"This is the author before the segue %@", self.author);
            [self performSegueWithIdentifier:@"barcodeToDetailsSegue" sender:nil];
            
        }
    }];
    [task resume];
}

@end
