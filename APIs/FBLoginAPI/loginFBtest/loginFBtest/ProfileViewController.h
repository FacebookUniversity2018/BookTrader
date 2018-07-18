//
//  ProfileViewController.h
//  loginFBtest
//
//  Created by Chaliana Rolon on 7/17/18.
//  Copyright © 2018 Chaliana Rolon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController
    
    @property (weak, nonatomic) IBOutlet UIImageView *profileImage;
    @property (weak, nonatomic) IBOutlet UILabel *username;
    @property NSString *name;
    @property NSURL *pictureURL;
    

@end
