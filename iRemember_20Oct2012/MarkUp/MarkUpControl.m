//
//  MarkUpControl.m
//  iRemember
//
//  Created by Charles Shin on 10/18/12.
//  Copyright (c) 2012 Group 11. All rights reserved.
//

#import "MarkUpControl.h"
#import "fileIOController.h"

@interface MarkUpControl ()

@end

@implementation MarkUpControl

@synthesize textView,imageView,naviTitle, photoImage, noteFile, textFieldString, textData, saveField, naviItem;
@synthesize buttonDone,buttonNote,buttonOption,buttonTag, buttonDraw;
@synthesize tagPath, filePath;

-(IBAction)alert
{
    UIAlertView *alertMenu = [[UIAlertView alloc] initWithTitle:@"Tag options" message:@"You can add, edit, or remove a tag" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", @"Edit", @"Remove", nil];
    
    [alertMenu show];
    
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    NSString *tagPath = [[NSString alloc] init];
        
    if([title isEqualToString:@"Add"])
    {
        NSLog(@"In Add");
        UIAlertView *alertAddMenu = [[UIAlertView alloc] initWithTitle:@"Add a new tag" message:@"Please enter a one word tag" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save",  nil];
                
        [alertAddMenu addSubview:saveField];
        saveField.text = @"";
        [alertAddMenu show];
        
    }
    
    else if([title isEqualToString:@"Edit"])
    {
        UIAlertView *alertEditMenu = [[UIAlertView alloc] initWithTitle:@"Edit an existing tag" message:@"Please edit an existing tag" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save", nil];
        
        [alertEditMenu addSubview:saveField];
        [alertEditMenu show];    
        
        NSString *fieldText = [[NSString alloc]init];
        fieldText = [[NSString alloc] initWithData: [noteFile readTheFile:tagPath] encoding:NSUTF8StringEncoding];
        
        saveField.text = fieldText;
        
        
    }    
    else if([title isEqualToString:@"Remove"])
    {
        NSLog(@"REmove");
        [noteFile writeOnTheFile:tagPath dataFrom: @""];
    }
    
    else if([title isEqualToString:@"Save"])
    {
        NSLog(@"save");
        
        if([self isLong:saveField.text])
        {
            UIAlertView *alertLength = [[UIAlertView alloc] initWithTitle:@"The tag is too long" message:@"Please enter words less than 40 character." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertLength show];
        }
        else
            [noteFile writeOnTheFile:tagPath dataFrom: saveField.text];
    }
    
}

-(UITextField *)alertTextField
{
    UITextField *alertTextField = [[UITextField alloc] initWithFrame:CGRectMake(12,45,260,25)];
    [alertTextField setBackgroundColor:[UIColor whiteColor]];
    
    return alertTextField;
}

-(BOOL) isLong:(NSString *)fieldText
{
    if ([fieldText length] > 41)
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    [self viewDesign];
    
    naviItem = [[UINavigationItem alloc] initWithTitle:@"Mark Up Page"];
    [naviTitle pushNavigationItem:naviItem animated:YES];
    [[naviTitle topItem]setTitle:@"Mark Up Page"];
    self.photoImage = [UIImage imageNamed:@"beach.png"];
    [self.imageView setImage:photoImage];
    [self setIconImage];    
    self.noteFile = [[fileIOController alloc] init];
    self.saveField = [[UITextField alloc]init];
    saveField = [self alertTextField];
    
    tagPath = [[NSString alloc] init];
    filePath  = [[NSString alloc]init];
    
    tagPath =  @"/Users/ycs3/Desktop/new/cmpt275-project/iRemember/tags.txt";
    filePath = @"/Volumes/KINGSTON/asg3/cmpt275-project/iRemember/output.txt";
    
    
}

-(void)viewDesign
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
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 44, 320, 189)];
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 320, 318)];
    naviTitle = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, -1, 320, 44)];
    
    textView.hidden = YES;
    naviTitle.hidden = NO;
       
    
    [self.view addSubview:naviTitle];
    [self.view addSubview:imageView];
    [self.view addSubview:textView];
    
    
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
    
    self.textData = [self.noteFile readTheFile:filePath];
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
    
}

- (void)saveAction:(id)sender {
    [self.textView resignFirstResponder];
    [[naviTitle topItem]setTitle:@"Note"];
    naviTitle.topItem.rightBarButtonItem = nil;
    naviTitle.topItem.leftBarButtonItem = nil;
    
    NSString *filePath = [[NSString alloc] init];
    
    
    [noteFile writeOnTheFile:filePath dataFrom:self.textView.text];
    
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
/*
-(void) drawOnImage
{
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:drawImage];
}//*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
