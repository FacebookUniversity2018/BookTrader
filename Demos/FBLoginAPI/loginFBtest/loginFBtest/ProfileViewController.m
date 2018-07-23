//
//  ProfileViewController.m
//  loginFBtest
//
//  Created by Chaliana Rolon on 7/17/18.
//  Copyright © 2018 Chaliana Rolon. All rights reserved.
//

#import "ProfileViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "UIImageView+AFNetworking.h"
#import "Parse.h"
#import "ParseUI.h"
#import "User.h"

@interface ProfileViewController ()
    
    @property (weak, nonatomic) IBOutlet PFImageView *rawImage;
    
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Succesfully loaded Profile VC");
    self.username.text = self.name;
    [self.profileImage setImageWithURL:self.pictureURL];
    
    // Code to retrieve the UIImage raw data
    NSData *imageData = [NSData dataWithContentsOfURL:self.pictureURL];
    UIImage *image = [UIImage imageWithData:imageData];
    
    // For Parse size purposes
    [self resizeImage:image withSize:CGSizeMake(50, 50)];
    
    if(image!=nil)  {
        NSLog(@"Image retrieved");
        self.rawImage.image = image;
        // Get PFFile
        PFFile *imageFile = [ProfileViewController getPFFileFromImage:self.rawImage.image];
        if(imageFile!=nil) {
            NSLog(@"Created pffile for image");
        }
    }
}
- (IBAction)onBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 
/**
 Method to convert UIImage to PFFile:
 
 - parameter image: Image that the user wants to upload to parse
 - returns: PFFile for the the data in the image
 */
+ (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image {
    
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFile fileWithName:@"image.png" data:imageData];
}
  
    
    
- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
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
