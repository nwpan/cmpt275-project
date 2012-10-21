//
//  MarkUpControl.h
//  iRemember
//
//  Created by Charles Shin on 10/18/12.
//  Copyright (c) 2012 Group 11. All rights reserved.
//

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

@property (strong, nonatomic) NSString *tagPath;
@property (strong,nonatomic) NSString *filePath;

//will show alert message
-(IBAction)alert;

//action of each button
- (IBAction)optionAction:(id)sender;
- (IBAction)doneAction:(id)sender;
- (IBAction)noteAction:(id)sender;
- (IBAction)tagAction:(id)sender;
- (IBAction)drawAction:(id)sender;




@end
