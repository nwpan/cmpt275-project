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
 * Know bugs: No bugs
 *
 *
 * Last revised on 2012-10-21
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

#import "MainMenuViewController.h"

@interface MainMenuViewController () 

@end

@implementation MainMenuViewController


-(IBAction)gallery{
    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
    picker.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [[self navigationController] presentModalViewController:picker animated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
    }
    return self;
}

-(void)takePicture:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    //Use camera if device has one otherwise use photo library
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    else
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
    [imagePicker setDelegate:self];
    
    //Show image picker
    [self presentModalViewController:imagePicker animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //Get image
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //UIImageView *imageView = nil;
    
    [self.imageView setImage:image];
    // Take image picker off the screen (required)
    [self dismissModalViewControllerAnimated:YES];
}

-(void) setup
{
    [self setupAppearance];
}

-(void) setupAppearance{
    UIBarButtonItem *cameraBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(takePicture:)];
    
    [[self navigationItem] setRightBarButtonItem:cameraBarButtonItem];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:[defaults objectForKey:@"user_id"] delegate:self cancelButtonTitle:@"Hide" otherButtonTitles:nil];
    //[alert show];
    [self setup];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
