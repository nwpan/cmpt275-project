//
//  SecondEditViewController.h
//  iRemember_20Oct2012
//
//  Created by Steven Tjendana on 10/20/12.
//  Copyright (c) 2012 Steven Tjendana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondEditViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    IBOutlet UIImageView *imageView;
    UIImage *imagePassed;
}
@property (nonatomic, retain)UIImage *imagePassed;
@end