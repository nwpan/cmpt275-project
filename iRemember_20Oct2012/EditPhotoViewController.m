//
//  EditPhotoViewController.m
//  iRemember_20Oct2012
//
//  Created by Steven Tjendana on 10/20/12.
//  Copyright (c) 2012 Steven Tjendana. All rights reserved.
//

#import "EditPhotoViewController.h"
#import "SecondEditViewController.h"


@interface EditPhotoViewController ()

@end

@implementation EditPhotoViewController
@synthesize locationManager;
@synthesize mapView;

@synthesize secondViewData;


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

-(IBAction)edit:(id)sender{
    SecondEditViewController *second = [[SecondEditViewController alloc]initWithNibName:nil bundle:nil];
    
    self.secondViewData = second;
    
    //UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    secondViewData.imagePassed = imageView.image;
    
    [self presentModalViewController:second animated:YES];
    
}


-(IBAction)gallery{
    picker2 = [[UIImagePickerController alloc]init];
    picker2.delegate = self;
    [picker2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentModalViewController:picker2 animated:YES];
}



-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [imageView setImage:image];
    
    [self dismissModalViewControllerAnimated:YES];
}



-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
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
	// Do any additional setup after loading the view.
    //sc.selectedSegmentIndex = -1;
}

- (void)viewDidUnload
{
    [self setLocationManager:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

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
    
    
}

- (IBAction)geotag:(id)sender {
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
}

- (IBAction)view:(id)sender {
    MKCoordinateRegion region;
    region.center.latitude = latitude;
    region.center.longitude = longitude;
    region.span.longitudeDelta = 0.1;
    region.span.latitudeDelta = 0.1;
    [mapView setRegion:region animated:YES];
}
- (void)dealloc {
    [locationManager release];
    [super dealloc];
}
@end
