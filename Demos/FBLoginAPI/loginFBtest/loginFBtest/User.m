//
//  User.m
//  loginFBtest
//
//  Created by Connor Clancy on 7/23/18.
//  Copyright © 2018 Chaliana Rolon. All rights reserved.
//

#import "User.h"
#import <Parse/Parse.h>

@implementation User

@dynamic userId;
@dynamic firstName;
@dynamic lastName;
@dynamic bio;
@dynamic profilePicture;

+ (nonnull NSString *)parseClassName {
    return @"User";
}

+(void)addUserToDatabase:(NSString *)userId withFirstName:(NSString *)firstName withLastName:(NSString *)lastName withBio:(NSString *)bio withProfilePicture:(PFFile *)profilePicture withCompletion:(PFBooleanResultBlock _Nullable)completion {
    User *newUser = [User new];
    newUser.userId = userId;
    newUser.firstName = firstName;
    newUser.lastName = lastName;
    newUser.bio = bio;
    newUser.profilePicture = profilePicture;
    
    [newUser saveInBackgroundWithBlock:completion];
};

// function that takes a user id and returns a User object
- (void) getUserWithID: (NSString *) userID {
    __block User *user = [User new];
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    [query includeKey:@"userId"];
    [query whereKey:@"userId" containsString:userID];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if(!error) {
            user = objects[0];
        } else {
            NSLog(@"%@", error.localizedDescription);
            user = nil;
        }
    }];
}

/**
 Method to convert UIImage to PFFile
 - parameter image: Image that the user wants to upload to parse
 - returns: PFFile for the the data in the image
 */
+ (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image {
    // check if image is not nil
    if (!image) {
        return nil;
    }
    NSData *imageData = UIImagePNGRepresentation(image);
    
    // get image data and check ifthat is not nil
    if (!imageData) {
        return nil;
    }
    return [PFFile fileWithName:@"image.png" data:imageData];
}

@end
