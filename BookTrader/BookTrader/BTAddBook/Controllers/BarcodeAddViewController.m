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

//-(void) stopReading;

@end

@implementation BarcodeAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.captureSession = nil;
    self.capturing = NO;
    // Do any additional setup after loading the view.
//}

//- (void)viewDidAppear:(BOOL)animated {
    self.captureSession = nil;
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
    [self performSegueWithIdentifier:@"barcodeToDetailsSegue" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
  //  if ([[segue identifier] isEqualToString:@"barcodeToDetailsSegue"]) {
        AddBookDetailsViewController *bookDetailsViewController = [segue destinationViewController];
        bookDetailsViewController.isbn = self.isbn;
      //  bookDetailsViewController.currentLocation = self.currentLocation;
   // } else if ([[segue identifier] isEqualToString:@"barcodeAddToHomeSegue"]) {
        
   // } else {
      //  NSLog([segue identifier]);
   // }
}

@end
