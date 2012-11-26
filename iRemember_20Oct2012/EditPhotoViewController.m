/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * EditPhotoViewController.m
 * iRemember
 *
 * Created by Steven Tjendana on 10/20/12.
 * Copyright (c) 2012 Group 11. All rights reserved.
 *
 * Programmer: Steven Tjendana, Jake Nagazine, Charles Shin, Nicholas Pan
 * Team Name: Double One
 * Project Name: iRemember
 * Version: Version 1.0
 *
 * This object manages photo album and geographical location.
 * A user can browse different photo albums to select desired photo.
 * When the user selected the photo it will displayed on the screen. 
 * The user can mark up this photo by touching mark up button.
 * The user can also get current location information.
 *
 *
 * Changes:
 *   2012-10-20 Created
 *   2012-10-21 Add comments
 *   2012-11-19 Integrate features in markup page(tag, note) into this page.
 *   2012-11-20 Implement drawing feature, save data using coredata
 *   2012-11-21 Implement geotag
 *   2012-11-22 Change UI and add tab bar
 *   2012-11-24 Fix minor bugs
 *
 * Known bugs: Not yet found
 *
 *
 * Last revised on 2012-11-24
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

#import "EditPhotoViewController.h"
#import "ViewGeotagViewController.h"
#import "Tag.h"
#import "Note.h"
#import "Geotag.h"


@interface EditPhotoViewController ()

@end

@implementation EditPhotoViewController
@synthesize updateGeotagAction;
@synthesize locationLabel;
@synthesize dateLabel;

@synthesize locationManager;
@synthesize locationmanager;
@synthesize mapView;

@synthesize textView, imageView, drawingView, myImage;

@synthesize tabBar, tagTabBarItem, noteTabBarItem, drawTabBarItem, tabItems, cameraBarButtonItem;

@synthesize imageURL;
@synthesize textFieldString, saveField;

/* Instance variables */
double longitude;
double latitude;
Tag *currentTag;
Note *currentNote;
NSString *URLString;

/* Code to be executed when Update Geotag button is pushed */
- (IBAction)updateGeotagAction:(id)sender {
    [self geotagAction]; // Updates the Geotag on the image
    
    NSString *URLString = [imageURL absoluteString];
    NSArray *foundArray = [Geotag MR_findByAttribute:@"image_id" withValue: URLString];
    
    Geotag *found = [foundArray objectAtIndex:0]; // Finds the tag object of the image displayed
    locationLabel.Text = [NSString stringWithFormat:@"[%f, %f]", [found.longitude doubleValue], [found.latitude doubleValue]];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMM d yyyy, K:mm a, z"];
    
    NSDate *date = found.date;
    
    NSString *dateString = [format stringFromDate: date];
    
    dateLabel.Text = dateString; // Changes the date label to a properly formatted string
}

/* Code to be executed when a new geotag is requested */
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{

    [manager stopUpdatingLocation]; // Stop pulling data from GPS

    latitude = newLocation.coordinate.latitude;
    longitude = newLocation.coordinate.longitude;

    NSLog(@"- Latitude: %f\n", latitude);
    NSLog(@"- Longitude: %f\n", longitude);

    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMM d yyyy, K:mm a, z"];

    NSDate *now = [[NSDate alloc] init];

    NSString *dateString = [format stringFromDate: now];

    NSLog(@"- Timestamp: %@\n", dateString);
    
    URLString = [imageURL absoluteString];
    
    NSLog(@"- ID: %@\n", URLString);
    
    NSManagedObjectContext *localContext = [NSManagedObjectContext MR_contextForCurrentThread];
    
    Geotag *geotagFound = [Geotag MR_findByAttribute:@"image_id" withValue:URLString inContext:localContext].lastObject;
    
    // If a geotag already exists
    if (geotagFound)
    {
        // Update the tag info
        NSLog(@"UPDATING EXISTING GEOTAG INFO");
        geotagFound.image_id = URLString;
        geotagFound.latitude = [NSNumber numberWithDouble:latitude];
        geotagFound.longitude = [NSNumber numberWithDouble:longitude];
        geotagFound.date = now;
        
        [localContext MR_saveNestedContexts];
    }
    
    //Otherwise make a new geotag associated with the picture displayed
    else
    {
        NSLog(@"CREAING NEW GEOTAG");
        Geotag *geotag = [Geotag MR_createInContext:localContext];
        geotag.image_id = URLString;
        geotag.latitude = [NSNumber numberWithDouble:latitude];
        geotag.longitude = [NSNumber numberWithDouble:longitude];
        geotag.date = now;
        
        [localContext MR_saveNestedContexts];
    }
}

/*
 * Using information of geotag, map will be displayed on seperate view
 *
 */
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
     
    /* If the user views a geotag, the information is passed to a different view with a larger map */
    if([segue.identifier isEqualToString:@"geotagSegue"])
    {
        NSString *URLString = [imageURL absoluteString];
        NSManagedObjectContext *localContext = [NSManagedObjectContext MR_contextForCurrentThread];
        Geotag *geotag = [Geotag MR_findByAttribute:@"image_id" withValue:URLString inContext:localContext].lastObject;
        MKCoordinateRegion regionSent;
        double latitude = [geotag.latitude doubleValue];
        double longitude = [geotag.longitude doubleValue];
        regionSent.center.latitude = latitude;
        regionSent.center.longitude = longitude;
        regionSent.span.longitudeDelta = 0.1;
        regionSent.span.latitudeDelta = 0.1;
        ViewGeotagViewController *viewGeotag = [segue destinationViewController];
        viewGeotag.region = regionSent;
    }
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

-(void) setupAppearance
{
    cameraBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(takePicture:)];
    
    [[self navigationItem] setRightBarButtonItem:cameraBarButtonItem];
    __block UIImage *image;
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];


    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *rep = [myasset defaultRepresentation];
        CGImageRef iref = [rep fullResolutionImage];
        if (iref) {
            image = [UIImage imageWithCGImage:iref];
            [imageView setImage:image];
            [drawingView setImage:image];
        }
    };

    //
    ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror)
    {
        NSLog(@"booya, cant get image - %@",[myerror localizedDescription]);
    };

    NSURL *url = imageURL;
    if (url != nil)
    {
        [assetslibrary assetForURL:url
                   resultBlock:resultblock
                  failureBlock:failureblock];
    }

    [self tabBarSet];
}

-(void)tabBarSet
{
    tabBar = [[UITabBar alloc] initWithFrame:CGRectMake(0, 376, 320, 44)];
    [[self tabBar] setBackgroundColor:[UIColor greenColor]];
    
    tagTabBarItem = [[UITabBarItem alloc] initWithTitle:@"Tag" image:[UIImage imageNamed:@"tab.png"] tag:0];
    noteTabBarItem = [[UITabBarItem alloc] initWithTitle:@"Note" image:[UIImage imageNamed:@"tab.png"] tag:1];
    drawTabBarItem = [[UITabBarItem alloc] initWithTitle:@"Draw" image:[UIImage imageNamed:@"tab.png"] tag:2];
    
    
    
    tabItems = [NSArray arrayWithObjects:tagTabBarItem, noteTabBarItem, drawTabBarItem, nil];
    [tabBar setItems:tabItems];
    [tabBar setSelectedItem:nil];
    tabBar.delegate = self;
    
    [self.view addSubview:tabBar];
}

-(void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if(item.tag == 0)
    {
        [self tagAction];
    }
    
    else if(item.tag == 1)
    {
        [self noteAction];
    }
    else if(item.tag == 2)
    {
        [self drawAction];
    }
    else if (item.tag == 3)
    {
        [self saveAction];
    }
    else if (item.tag == 4)
    {
        [self cancelAction];
    }

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
    [self setup];
    [imageView setImage:myImage];
    [drawingView setImage:myImage];
    [textView setDelegate:self];
    saveField = [self alertTextField];
    
    
    /* The code below automatically geotags an image if it does not have a geotag upon being viewed */
    NSString *URLString = [imageURL absoluteString];
    NSArray *foundArray = [Geotag MR_findByAttribute:@"image_id" withValue: URLString];
    
    if ([foundArray count] <= 0)
    {
        [self geotagAction];
    }
    
    else
    {
        Geotag *found = [foundArray objectAtIndex:0];
        locationLabel.Text = [NSString stringWithFormat:@"[%f, %f]", [found.longitude doubleValue], [found.latitude doubleValue]];
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"MMM d yyyy, K:mm a, z"];
        
        NSDate *date = found.date;
        
        NSString *dateString = [format stringFromDate: date];
        
        dateLabel.Text = dateString;
    }
}

- (void)viewDidUnload
{
    [self setLocationManager:nil];
    [self setLocationLabel:nil];
    [self setDateLabel:nil];
    [self setTextView:nil];
    [self setDrawingView:nil];
    [self setUpdateGeotagAction:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//Add tag
-(void)tagAction
{
    [self setTitle:@"Tag"];
    textView.hidden = YES;
    [[self navigationItem]setLeftBarButtonItem:nil];
    [self alert];
}

-(IBAction)alert
{
    //alert with tag options: add, edit, or remove.
    UIAlertView *alertMenu = [[UIAlertView alloc] initWithTitle:@"Tag options" message:@"You can add, edit, or remove a tag" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", @"Edit", @"Remove", nil];
    
    [alertMenu show];
    
}

//Tag selection options
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex]; //stores title of buttons on the alert
    NSManagedObjectContext *localContext = [NSManagedObjectContext MR_contextForCurrentThread];
    
    if([title isEqualToString:@"Add"]) //add the tag to the photo when add is touched
    {
        //alert with textfield will be created for a user to enter the tag.
        UIAlertView *alertAddMenu = [[UIAlertView alloc] initWithTitle:@"Add a new tag" message:@"Please enter a one word tag" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save",  nil];
        
        currentTag = [Tag MR_createInContext:localContext];
        
        [alertAddMenu addSubview:saveField];
        saveField.text = @""; //clear the saveField.
        [alertAddMenu show];
        
    }
    
    else if([title isEqualToString:@"Edit"]) //edit the tag on the photo when edit is touched
    {
        
        Tag *tagFounded = [Tag MR_findByAttribute:@"image_path" withValue:[imageURL absoluteString] inContext:localContext].lastObject;
        
        UIAlertView *alertEditMenu = [[UIAlertView alloc] initWithTitle:@"Edit an existing tag" message:@"Please edit an existing tag" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save", nil];
        
        [alertEditMenu addSubview:saveField];
        [alertEditMenu show];
        
        NSString *fieldText = [[NSString alloc]init];
        
        if (tagFounded)
        {
            fieldText = [[NSString alloc] initWithString:[tagFounded word]];
            currentTag = tagFounded;
        }
        else
        {
            currentTag = [Tag MR_createInContext:localContext];
            currentTag.word = @"";
            fieldText = currentTag.word;
        }
        saveField.text = fieldText;
    }
    else if([title isEqualToString:@"Remove"]) //remove the tag on the photo when remove is touched
    {
        Tag *tagFounded = [Tag MR_findByAttribute:@"image_path" withValue:[imageURL absoluteString] inContext:localContext].lastObject;
        
        if (tagFounded)
        {
            [tagFounded MR_deleteInContext:localContext];
        }
        
        [localContext MR_saveNestedContexts];
    }
    
    else if([title isEqualToString:@"Save"]) //save new or changed tag to file storing tags data.
    {
        
        if (!currentTag)
        {
            currentTag = [Tag MR_createInContext:localContext];
        }
        else
        {
            currentTag.word = saveField.text;
        }
        currentTag.image_path = [imageURL absoluteString];
        
        [localContext MR_saveNestedContexts]; //write to file if tag is valid.
        
        
    }
    
    
}
//creats text field used in alert
-(UITextField *)alertTextField
{
    UITextField *alertTextField = [[UITextField alloc] initWithFrame:CGRectMake(12,45,260,25)];
    [alertTextField setBackgroundColor:[UIColor whiteColor]];
    
    return alertTextField;
}


//Edit note
-(void)noteAction
{
    NSManagedObjectContext *localContext = [NSManagedObjectContext MR_contextForCurrentThread];
    
    Note *noteFounded = [Note MR_findByAttribute:@"image_path" withValue:[imageURL absoluteString] inContext:localContext].lastObject;
    
    if (noteFounded)
    {
        currentNote = noteFounded;
    }
    else
    {
        currentNote = [Note MR_createInContext:localContext];
    }
    
    [self setTitle:@"Note"];
    textView.hidden = NO;
    
    self.textFieldString = [currentNote desc];
    [textView setText:textFieldString];
    
    //creat done button
    UIBarButtonItem* doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                              target:self
                                                                              action:@selector(noteCancelAction:)];
    //naviTitle.topItem.leftBarButtonItem = doneItem;
    [[self navigationItem] setLeftBarButtonItem:doneItem];
}

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * saveAction and cancelAction attached to save and cancel button.
 * These two buttons will only be appear when the user edits the note.
 * When the user done editing, these buttons will be deleted.
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

//Save the contents of the note to note file using fileIOController
- (void)noteSaveAction:(id)sender {
    [self.textView resignFirstResponder];
    [self setTitle:@"Note"];
    
    NSManagedObjectContext *localContext = [NSManagedObjectContext MR_contextForCurrentThread];
    Note *noteFounded = [Note MR_findByAttribute:@"image_path" withValue:[imageURL absoluteString] inContext:localContext].lastObject;
    
    if (noteFounded)
    {
        currentNote = noteFounded;
    }
    else
    {
        currentNote = [Note MR_createInContext:localContext];
    }
    
    currentNote.image_path = [imageURL absoluteString];
    currentNote.desc = self.textView.text;
    
    [localContext MR_saveNestedContexts];
    [[self navigationItem]setLeftBarButtonItem:nil];
    [[self navigationItem]setRightBarButtonItem:nil];
}

//Dismiss the note without saving edited contents
- (void)noteCancelAction:(id)sender {
    
    [self.textView resignFirstResponder];
    textView.hidden = YES;
    [[self navigationItem]setLeftBarButtonItem:nil];
    [[self navigationItem]setRightBarButtonItem:cameraBarButtonItem];
    
}

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * When textView, which displays and edits the note, is loaded, begin editing,
 * save and cancel button will be created on the navigation title bar.
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [self setTitle:@"Editing"];
    UIBarButtonItem* saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                              target:self
                                                                              action:@selector(noteSaveAction:)];
    
    
    
    UIBarButtonItem* cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                target:self
                                                                                action:@selector(noteCancelAction:)];
    
    [[self navigationItem]setRightBarButtonItem:saveItem];
    [[self navigationItem]setLeftBarButtonItem:cancelItem];
    
}

//The note will be disappear when the user done editing
-(void)textViewDidEndEditing:(UITextView *)textView
{
    self.textView.hidden = YES;
}

//Draw will be activated so that a user can draw on the image.
-(void)drawAction
{
    [self setTitle:@"Draw"];
    
    textView.hidden = YES;
    imageView.hidden = YES;
    drawingView.hidden = NO;
    
    //add buttons on tabbar to save or cancel 
    UITabBarItem *saveTabBarItem = [[UITabBarItem alloc]initWithTitle:@"Save" image:[UIImage imageNamed:@"tab.png"] tag:3];
    UITabBarItem *cancelTabBarItem = [[UITabBarItem alloc]initWithTitle:@"Cancel" image:[UIImage imageNamed:@"tab.png"] tag:4];
    
    NSArray *drawItems = [[NSArray alloc]initWithObjects:saveTabBarItem, cancelTabBarItem, nil];
    
    [[self navigationItem]setLeftBarButtonItem:nil];
    [tabBar setItems:drawItems];
}

//Save image with draw
-(void)saveAction
{
    //UIImageWriteToSavedPhotosAlbum(drawingView.image, nil, nil, nil);
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    [library writeImageToSavedPhotosAlbum:[drawingView.image CGImage] orientation:   (ALAssetOrientation)[drawingView.image imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error)
     {
         if (error)
         {
             NSLog(@"Error saving drawing to photo library");
         }
         else
         {
             NSLog(@"SAVED");
             //imageURL = assetURL;
         }
     }];
    imageView.image = drawingView.image;
    imageView.hidden = NO;
    drawingView.hidden =YES;
    [tabBar setItems:tabItems];
}

-(void)cancelAction
{
    imageView.hidden = NO;
    drawingView.hidden = YES;
    [tabBar setItems:tabItems];
}

- (void)geotagAction
{
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
}


//view map

/* Transfers geotag data to a new view with a large map to view */
- (IBAction)viewAction:(id)sender
{
    NSString *URLString = [imageURL absoluteString];
    NSArray *foundArray = [Geotag MR_findByAttribute:@"image_id" withValue: URLString];
    
    if ([foundArray count] > 0)
    {
        Geotag *found = [foundArray objectAtIndex:0];
    
        latitude = [found.latitude doubleValue];
        longitude = [found.longitude doubleValue];
    
        MKCoordinateRegion region;
        region.center.latitude = latitude;
        region.center.longitude = longitude;
        region.span.longitudeDelta = 0.1;
        region.span.latitudeDelta = 0.1;
        [mapView setRegion:region animated:YES];
    }

/* If the button does not have a geotag (somehow), an error message is displayed */
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"This picture has no geotag.  Display failed." delegate:self cancelButtonTitle:@"Hide" otherButtonTitles:nil];
        [alert show];
    }
}

@end
