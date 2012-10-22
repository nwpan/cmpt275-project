/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * MarkUpControl.m
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
 *   2012-10-18 Created general layout of the view using storyboard and assign NSLog to each button to test 
 *              if right button is clicked.
 *   2012-10-19 Implement add note function using fileIOController. Also implemented Tag function using alert.
 *   2012-10-20 Recreated layout of the view using codes to minimize merge conflict. 
 *              Implement adding, editing, and removing of a tag using fileIOController.
 *   2012-10-21 Fixed minor bugs. Add comments
 *
 * Know bugs: No bugs
 *
 * To do: Implement draw and option button
 *
 * Last revised on 2012-10-21
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

#import "MarkUpControl.h"
#import "fileIOController.h"

@interface MarkUpControl ()

@end

@implementation MarkUpControl

@synthesize textView,imageView,naviTitle, photoImage, noteFile, textFieldString, textData, saveField, naviItem;
@synthesize buttonDone,buttonNote,buttonOption,buttonTag, buttonDraw;
@synthesize tagFilePath, myNoteFilePath;


/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * Alert is used to add, edit, or remove a tag on a photo.
 * Tags will be saved as string type.
 * When remove the tag, the empty string tag will be saved as the tag.
 * Tags have to be 45 characters or less.
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
-(IBAction)alert
{
    //alert with tag options: add, edit, or remove.
    UIAlertView *alertMenu = [[UIAlertView alloc] initWithTitle:@"Tag options" message:@"You can add, edit, or remove a tag" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", @"Edit", @"Remove", nil];
    
    [alertMenu show];   
        
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex]; //stores title of buttons on the alert
        
    if([title isEqualToString:@"Add"]) //add the tag to the photo when add is touched
    {
        //alert with textfield will be created for a user to enter the tag.
        UIAlertView *alertAddMenu = [[UIAlertView alloc] initWithTitle:@"Add a new tag" message:@"Please enter a one word tag" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save",  nil];
                
        [alertAddMenu addSubview:saveField];
        saveField.text = @""; //clear the saveField.
        [alertAddMenu show];
        
    }
    
    else if([title isEqualToString:@"Edit"]) //edit the tag on the photo when edit is touched
    {
        UIAlertView *alertEditMenu = [[UIAlertView alloc] initWithTitle:@"Edit an existing tag" message:@"Please edit an existing tag" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save", nil];
        
        [alertEditMenu addSubview:saveField];
        [alertEditMenu show];    
        
        NSString *fieldText = [[NSString alloc]init];
        fieldText = [[NSString alloc] initWithData: [noteFile readTheFile:tagFilePath] encoding:NSUTF8StringEncoding];
        
        saveField.text = fieldText;
        
        
    }    
    else if([title isEqualToString:@"Remove"]) //remove the tag on the photo when remove is touched
    {
        [noteFile writeOnTheFile:tagFilePath dataFrom: @""];
    }
    
    else if([title isEqualToString:@"Save"]) //save new or changed tag to file storing tags data.
    {
        if([self isLong:saveField.text]) //warns a user if one types more than 45 characters
        {
            UIAlertView *alertLength = [[UIAlertView alloc] initWithTitle:@"The tag is too long" message:@"Please enter words less than 45 character." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertLength show];
        }
        else
            [noteFile writeOnTheFile:tagFilePath dataFrom: saveField.text]; //write to file if tag is valid.
    }
    
}

//creats text field used in alert
-(UITextField *)alertTextField
{
    UITextField *alertTextField = [[UITextField alloc] initWithFrame:CGRectMake(12,45,260,25)];
    [alertTextField setBackgroundColor:[UIColor whiteColor]];
    
    return alertTextField;
}

//checks length of the text user typed.
-(BOOL) isLong:(NSString *)fieldText
{
    if ([fieldText length] > 46)
        return YES;
    else
        return NO;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* When view is loaded, displayViewDesign will be called to create appearance of the view.
* Also set title of view and set filepath for tag and note as well as load the image from the album
* 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    [self displayViewDesign];
    
    naviItem = [[UINavigationItem alloc] initWithTitle:@"Mark Up Page"];
    [naviTitle pushNavigationItem:naviItem animated:YES];
    
    [self.imageView setImage:photoImage];
    
    self.noteFile = [[fileIOController alloc] init];
    self.saveField = [[UITextField alloc]init];
    saveField = [self alertTextField];
    
    self.tagFilePath = [[NSString alloc] init];
    self.myNoteFilePath  = [[NSString alloc]init];
    
    //set the path of each file to devices local storage
    self.tagFilePath = [[NSBundle mainBundle] pathForResource:@"tags" ofType:@"txt"];    
    self.myNoteFilePath = [[NSBundle mainBundle] pathForResource:@"output" ofType:@"txt"];    
    
}

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * This will create graphic user interface of the view
 *
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
-(void)displayViewDesign
{
    //create buttons
    buttonDone = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonDone.frame = CGRectMake(241, 413, 75, 42);
    [buttonDone setTitle:@"DONE" forState:UIControlStateNormal];
    [buttonDone addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonDone];
    
    buttonOption = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonOption.frame = CGRectMake(241, 365, 75, 42);
    [buttonOption setTitle:@"Option" forState:UIControlStateNormal];
    [buttonOption addTarget:self action:@selector(optionAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonOption];
    
    buttonDraw = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonDraw.frame = CGRectMake(4, 365, 75, 90);
    [buttonDraw setTitle:@"Draw" forState:UIControlStateNormal];
    [buttonDraw addTarget:self action:@selector(drawAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonDraw];
    
    buttonTag = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonTag.frame = CGRectMake(83, 365, 75, 90);
    [buttonTag setTitle:@"Tag" forState:UIControlStateNormal];
    [buttonTag addTarget:self action:@selector(tagAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonTag];
    
    buttonNote = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonNote.frame = CGRectMake(162, 365, 75, 90);
    [buttonNote setTitle:@"Note" forState:UIControlStateNormal];
    [buttonNote addTarget:self action:@selector(noteAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonNote];
    
    //creates views and title bar
    textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 44, 320, 189)];
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 320, 318)];
    naviTitle = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, -1, 320, 44)];
    
    //show or hide objeccts
    textView.hidden = YES;
    textView.delegate = self;
    naviTitle.hidden = NO;
    //Draw and option will be implemented on Version 2. Therefore, it will be hidden.
    buttonOption.hidden = YES;
    buttonDraw.hidden = YES;
       
    
    [self.view addSubview:naviTitle];
    [self.view addSubview:imageView];
    [self.view addSubview:textView];
    
    [self setIconImage];
    
}

- (void)viewDidUnload
{
    [self setNaviTitle:nil];
    [self setButtonTag:nil];
    [self setButtonNote:nil];
    [self setButtonOption:nil];
    [self setButtonDone:nil];
    [self setButtonDraw:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (IBAction)optionAction:(id)sender {
    [[naviTitle topItem]setTitle:@"Option"];
    naviTitle.topItem.leftBarButtonItem = nil;
    textView.hidden = YES;
}

- (IBAction)doneAction:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)noteAction:(id)sender {
    [[naviTitle topItem]setTitle:@"Note"];
    textView.hidden = NO;
    
    self.textData = [self.noteFile readTheFile:myNoteFilePath];
    self.textFieldString = [[NSString alloc] initWithData:textData encoding:NSUTF8StringEncoding];
    [textView setText:textFieldString];
    
    UIBarButtonItem* doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self
                                                                                action:@selector(cancelAction:)];
    naviTitle.topItem.leftBarButtonItem = doneItem;
}

- (IBAction)tagAction:(id)sender {
    [[naviTitle topItem]setTitle:@"Tag"];
    naviTitle.topItem.leftBarButtonItem = nil;
    textView.hidden = YES;
    [self alert];
}

- (IBAction)drawAction:(id)sender {
    [[naviTitle topItem]setTitle:@"Draw"];
    naviTitle.topItem.leftBarButtonItem = nil;    
    textView.hidden = YES;
    
}

- (void)saveAction:(id)sender {
    [self.textView resignFirstResponder];
    [[naviTitle topItem]setTitle:@"Note"];
    naviTitle.topItem.rightBarButtonItem = nil;
    naviTitle.topItem.leftBarButtonItem = nil;    
    
    [noteFile writeOnTheFile:myNoteFilePath dataFrom:self.textView.text];
    
}

- (void)cancelAction:(id)sender {
    
    [self.textView resignFirstResponder];
    [[naviTitle topItem]setTitle:@"Note"];
    naviTitle.topItem.rightBarButtonItem = nil;
    naviTitle.topItem.leftBarButtonItem = nil;
    textView.hidden = YES;

}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [[naviTitle topItem]setTitle:@"Editing"];
    UIBarButtonItem* saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                              target:self
                                                                              action:@selector(saveAction:)];
    
    naviTitle.topItem.rightBarButtonItem = saveItem;
    
    UIBarButtonItem* cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                              target:self
                                                                              action:@selector(cancelAction:)];
    naviTitle.topItem.leftBarButtonItem = cancelItem;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    self.textView.hidden = YES;
}

-(void)setIconImage
{
    //set done button image
    UIImage *doneImage = [UIImage imageNamed:@"icon_done.png"];
    [buttonDone setImage:doneImage forState:UIControlStateNormal];
    
    //set draw button image
    UIImage *drawImage = [UIImage imageNamed:@"icon_draw.png"];
    [buttonDraw setImage:drawImage forState:UIControlStateNormal];
    
    //set note button image
    UIImage *noteImage = [UIImage imageNamed:@"icon_note.png"];
    [buttonNote setImage:noteImage forState:UIControlStateNormal];
    
    //set option button image
    UIImage *optionImage = [UIImage imageNamed:@"icon_option.png"];
    [buttonOption setImage:optionImage forState:UIControlStateNormal];
    
    //set tag button image
    UIImage *tagImage = [UIImage imageNamed:@"icon_tag.png"];
    [buttonTag setImage:tagImage forState:UIControlStateNormal];
    
    
}//*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
