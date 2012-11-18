/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * MainMenuViewController.h
 * iRemember_20Oct2012
 *
 * Created by Steven Tjendana on 10/20/12.
 * Copyright (c) 2012 Double One. All rights reserved.
 *
 * Programmer: Steven Tjendana
 * Team Name: Double One
 * Project Name: iRemember
 * Version: Version 1.0
 *
 * This manages main menu of our application
 *
 * Changes:
 *   2012-10-20 Created
 *   2012-10-21 Add comments
 *
 * Known bugs: No bugs
 *
 *
 * Last revised on 2012-10-21
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface MainMenuViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, retain) IBOutlet UIImageView *imageView;

@property (nonatomic, retain) AppDelegate *app;

-(IBAction)gallery;
@property (strong, nonatomic) IBOutlet UIButton *TestButton;

@end
