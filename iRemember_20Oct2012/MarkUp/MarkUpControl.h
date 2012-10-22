/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * MarkUpControl.h
 * iRemember
 *
 * Created by Charles Shin on 10/18/12.
 * Copyright (c) 2012 Group 11. All rights reserved.
 *
 * Programmer: Charles Shin
 * Team Name: Double One
 * Project Name: iRemember
 * Version: Version 1.0 
 *
 * This object manages mark up function of a photo.
 * A user can add a one word tag which can be used in search.
 * A one word tag is limited to 45 character since the longest word on a dictionary is 45 character long.
 * Also a user can add a descriptive note to a photo.
 * A photo will be selected from the album.
 *
 *
 * Changes:
 *   2012-10-18 Created
 *   2012-10-19 added noteFile, saveField, tagFilePath, myNoteFilePath, saveField, textData
 *   2012-10-21 Add comments
 *
 * Know bugs: No bugs
 *
 * To do: Implement draw and option button
 *
 * Last revised on 2012-10-21
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

#import <UIKit/UIKit.h>
#import "fileIOController.h"

@interface MarkUpControl : UIViewController


@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UINavigationBar *naviTitle;
@property (strong, nonatomic) IBOutlet UINavigationItem *naviItem;

@property (weak, nonatomic) IBOutlet UIButton *buttonDraw;
@property (weak, nonatomic) IBOutlet UIButton *buttonTag;
@property (weak, nonatomic) IBOutlet UIButton *buttonNote;
@property (weak, nonatomic) IBOutlet UIButton *buttonOption;
@property (weak, nonatomic) IBOutlet UIButton *buttonDone;

@property (weak, nonatomic) UIImage *photoImage;
@property (strong, nonatomic) UITextField *saveField;
@property (strong, nonatomic) fileIOController *noteFile;
@property (strong, nonatomic) NSString *textFieldString;
@property (strong, nonatomic) NSData *textData;

@property (strong, nonatomic) NSString *tagFilePath;
@property (strong,nonatomic) NSString *myNoteFilePath;

//will show alert message
-(IBAction)alert;

//action of each button
- (IBAction)doneAction:(id)sender;  //Exit mark up view
- (IBAction)noteAction:(id)sender;  //Add descriptive note on a photo
- (IBAction)tagAction:(id)sender;   //Add a one word tag to a photo. Limited to 45 characters.

/* To be implemented in version 2
- (IBAction)drawAction:(id)sender;
- (IBAction)optionAction:(id)sender;
*/


@end
