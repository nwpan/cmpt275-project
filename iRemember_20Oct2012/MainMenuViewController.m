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

#import "MainMenuViewController.h"
#import "EditPhotoViewController.h"

@interface MainMenuViewController () 

@end

@implementation MainMenuViewController
@synthesize TestButton;

@synthesize photoImage, myTextField;

NSURL *imagePickerUrl;

-(IBAction)alert
{
    //photo selection menu
    UIAlertView *alertMenu = [[UIAlertView alloc] initWithTitle:@"Select Photo" message:@"Select Photo" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"From Album", @"From Internet", @"Search", nil];
    
    [alertMenu show];
    
}

- (IBAction)selectPhotoAction:(id)sender {
    
    [self alert];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex]; //stores title of buttons on the alert
    //NSManagedObjectContext *localContext = [NSManagedObjectContext MR_contextForCurrentThread];
    UIAlertView *noURLAlert = [[UIAlertView alloc] initWithTitle:@"ALERT" message:@"You have not put any URL" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
    UIAlertView *wrongURLAlert = [[UIAlertView alloc] initWithTitle:@"ALERT" message:@"You have typed invalid URL" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
    UIImage *urlImage;
    
    if([title isEqualToString:@"From Album"]) //show photo album to pick photoes from
    {
        [self showPhotoLibrary];
        
    }
    
    else if([title isEqualToString:@"From Internet"]) //show alertmenu to type in URL
    {
        
        UIAlertView *openURLAlert = [[UIAlertView alloc] initWithTitle:@"Enter URL here" message:@"Please Enter URL" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        myTextField = [self alertMenuField];
        [openURLAlert addSubview:myTextField];
        [openURLAlert show];
        
    }
    else if([title isEqualToString:@"Search"]) //Move to search view
    {
        [self performSegueWithIdentifier:@"searchViewSegue" sender:self];        
    }
    else if ([title isEqualToString:@"OK"]) {
        
        if([myTextField.text length]==0)
        {
            [noURLAlert show];
        }
        else
        {
            NSString *URL;
            URL = myTextField.text;
            
            urlImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: URL]]];
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
            
            [library writeImageToSavedPhotosAlbum:[urlImage CGImage] orientation:   (ALAssetOrientation)[urlImage imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error)
             {
                 if (error)
                 {
                     [wrongURLAlert show];
                 }
                 else
                 {
                     NSLog(@"image loaded");
                     photoImage = urlImage;
                     imagePickerUrl = assetURL;
                     [self performSegueWithIdentifier:@"imageDetailSegue" sender:self];
                     //imageView.image = urlImage;
                     
                 }
             }];
        }
    }
}

-(void) showPhotoLibrary
{
    UIImagePickerController *myImagePicker;
    myImagePicker = [[UIImagePickerController alloc]init];
    myImagePicker.delegate = self;
    [myImagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentModalViewController:myImagePicker animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //Get image
    photoImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    imagePickerUrl = [info valueForKey: UIImagePickerControllerReferenceURL];
    //Segue to imageDetailView and take image picker off the screen
    [self performSegueWithIdentifier:@"imageDetailSegue" sender:self];
    [self dismissModalViewControllerAnimated:YES];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"imageDetailSegue"])
    {
        EditPhotoViewController *editPhoto = [segue destinationViewController];
        editPhoto.myImage = photoImage;
        editPhoto.photoUrl = imagePickerUrl;
        editPhoto.imageURL = imagePickerUrl;
    }
}

-(UITextField *) alertMenuField
{
    UITextField *tempTextField;
    tempTextField = [[UITextField alloc] initWithFrame: CGRectMake(12.0, 50.0, 260.0, 25.0)];
    [tempTextField setBackgroundColor:[UIColor whiteColor]];
    tempTextField.placeholder = @"Type here";
    tempTextField.borderStyle = UITextBorderStyleBezel;
    tempTextField.returnKeyType = UIReturnKeyDone;
    tempTextField.delegate = self;
    
    return tempTextField;
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
    [self setup];
}

- (void)viewDidUnload
{
    [self setTestButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
