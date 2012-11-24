/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * EditPhotoViewController.m
 * iRemember
 *
 * Created by Steven Tjendana on 10/20/12.
 * Copyright (c) 2012 Group 11. All rights reserved.
 *
 * Programmer: Steven Tjendana, Jake Nagazine
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
 *
 * Known bugs: No bugs
 *
 *
 * Last revised on 2012-10-21
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

#import "EditPhotoViewController.h"
#import "MarkUpControl.h"
#import "ViewGeotagViewController.h"
#import "Geotag.h"
#import "drawOnImage.h"


@interface EditPhotoViewController ()

@end

@implementation EditPhotoViewController
@synthesize locationLabel;
@synthesize dateLabel;

@synthesize locationManager;
@synthesize mapView;

@synthesize imageView;
@synthesize picker2;
@synthesize gallery;
@synthesize locationmanager;
@synthesize myTextField, myImage;
@synthesize tabBar, tagTabBarItem, noteTabBarItem, drawTabBarItem, tabItems;

@synthesize imgPickerUrl;
@synthesize imageURL;

/* Instance variables */
double longitude;
double latitude;

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{

    [manager stopUpdatingLocation];

    latitude = newLocation.coordinate.latitude;
    longitude = newLocation.coordinate.longitude;

    NSLog(@"- Latitude: %f\n", latitude);
    NSLog(@"- Longitude: %f\n", longitude);

    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMM d yyyy, K:mm a, z"];

    NSDate *now = [[NSDate alloc] init];

    NSString *dateString = [format stringFromDate: now];

    NSLog(@"- Timestamp: %@\n", dateString);
    
    NSString *URLString = [imageURL absoluteString];
 /*
  * NSArray* foo = [URLString componentsSeparatedByString: @"="]; // This code extracts only the ID from the URL.  For simplicity, we are not extracting the ID
  * NSString* URLPart1 = [foo objectAtIndex: 1];
  * NSString* URLPart2 = [foo objectAtIndex: 2];
  * NSString* URLPart3 = [URLPart1 stringByAppendingString:@"="];
  * NSString* URLID = [URLPart3 stringByAppendingString:URLPart2];
  */  
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
 * When the user press 'Edit' button, the view will be segue to Markup view.
 * The user selected photo will be transfer to markup view to be marked up.
 *
 */
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"markUpSegue"])
    {
        MarkUpControl *markUpPhoto = [segue destinationViewController];
        markUpPhoto.photoImage = imageView.image;
        markUpPhoto.photoUrl = imgPickerUrl;
    }
    
    //If the user presses the "View" button, the little map beside the button should
    //transfer to a fullsized map.  The small map will be retained
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
    UIBarButtonItem *cameraBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(takePicture:)];
    
    [[self navigationItem] setRightBarButtonItem:cameraBarButtonItem];
    __block UIImage *image;
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];


    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *rep = [myasset defaultRepresentation];
        CGImageRef iref = [rep fullResolutionImage];
        if (iref) {
            image = [UIImage imageWithCGImage:iref];
            imgPickerUrl = self.imageURL;
            [imageView setImage:image];
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

//a function to open the gallery
-(IBAction)galleryAction
{
    
    picker2 = [[UIImagePickerController alloc]init];
    picker2.delegate = self;
    [picker2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentModalViewController:picker2 animated:YES];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    imageURL = [info objectForKey:UIImagePickerControllerReferenceURL];
    [imageView setImage:image];
    imgPickerUrl = [info valueForKey: UIImagePickerControllerReferenceURL];
    [self dismissModalViewControllerAnimated:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
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
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setLocationManager:nil];
    [self setLocationLabel:nil];
    [self setDateLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)tagAction
{
    NSLog(@"Tag");
}

-(void)noteAction
{
    NSLog(@"note");
}

-(void)drawAction
{
    NSLog(@"draw");
    UITabBarItem *saveTabBarItem = [[UITabBarItem alloc]initWithTitle:@"Save" image:[UIImage imageNamed:@"tab.png"] tag:3];
    UITabBarItem *cancelTabBarItem = [[UITabBarItem alloc]initWithTitle:@"Cancel" image:[UIImage imageNamed:@"tab.png"] tag:4];
    NSArray *drawItems = [[NSArray alloc]initWithObjects:saveTabBarItem, cancelTabBarItem, nil];
    [tabBar setItems:drawItems];
   // drawOnImage *drawStart = [[drawOnImage alloc]init];
}

-(void)saveAction
{
    NSLog(@"save");
    [tabBar setItems:tabItems];
}

-(void)cancelAction
{
    NSLog(@"cancel");
    [tabBar setItems:tabItems];
}

- (IBAction)geotagAction:(id)sender
{
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
}


//view map
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
    
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"This picture has no geotag.  Display failed." delegate:self cancelButtonTitle:@"Hide" otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)openURLAction:(id)sender
{
    UIAlertView *openURLAlert = [[UIAlertView alloc] initWithTitle:@"Enter URL here" message:@"Please Enter URL" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    
    myTextField = [[UITextField alloc] initWithFrame: CGRectMake(12.0, 50.0, 260.0, 25.0)];
    [myTextField setBackgroundColor:[UIColor whiteColor]];
    [openURLAlert addSubview: myTextField];
    myTextField.placeholder = @"Type here";
    myTextField.borderStyle = UITextBorderStyleBezel;
    myTextField.returnKeyType = UIReturnKeyDone;
    myTextField.delegate = self;
    
    [openURLAlert show];
}


-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    UIAlertView *noURLAlert = [[UIAlertView alloc] initWithTitle:@"ALERT" message:@"You have not put any URL" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
    UIAlertView *wrongURLAlert = [[UIAlertView alloc] initWithTitle:@"ALERT" message:@"You have typed invalid URL" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
    UIImage *urlImage;
    
    if (buttonIndex == 1) {
        
        if([myTextField.text length]==0){
            [noURLAlert show];
        }else{
            NSString *URL;
            URL = myTextField.text;
            //imageView.image =
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
                    imageView.image = urlImage;
                    imgPickerUrl = assetURL;
                }  
            }];
        }
    }
}

@end
