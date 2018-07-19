//
//  BarcodeViewController.m
//  BarcodeAPI
//
//  Created by Connor Clancy on 7/17/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "BarcodeViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface BarcodeViewController () <AVCaptureMetadataOutputObjectsDelegate>
@property (strong, nonatomic) IBOutlet UIView *previewView;
@property (strong, nonatomic) IBOutlet UIButton *toggleButton;

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@property (nonatomic) BOOL capturing;

-(void)stopReading;

@end

@implementation BarcodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.captureSession = nil;
    self.capturing = NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)toggleReading:(id)sender {
    NSError *error;
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    } else {
        self.captureSession = [AVCaptureSession new];
        [self.captureSession addInput:input];
        
        AVCaptureMetadataOutput *captureMetadataOutput = [AVCaptureMetadataOutput new];
        [self.captureSession addOutput:captureMetadataOutput];
        
        dispatch_queue_t dispatchQueue;
        dispatchQueue = dispatch_queue_create("myQueue", NULL);
        [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
        // THIS TELLS IT TO LOOK FOR A QR CODE !
        [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeEAN13Code]];
        self.videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
        [self.videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
        [self.videoPreviewLayer setFrame:self.previewView.layer.bounds];
        [self.previewView.layer addSublayer:self.videoPreviewLayer];
        [self.captureSession startRunning];
        return YES;
    }
}

-(void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeEAN13Code]) {
            NSLog([metadataObj stringValue]);
            [self performSelectorOnMainThread:@selector(stopReading) withObject:[metadataObj stringValue] waitUntilDone:NO];
            self.capturing = NO;
        }
    }
}

-(void)stopReading {
    [self.captureSession stopRunning];
    self.captureSession = nil;
    [self.videoPreviewLayer removeFromSuperlayer];
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
