/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * EditPhotoViewController.h
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


#import <UIKit/UIKit.h>
#import "MarkUpControl.h"
#import "ViewGeotagViewController.h"

#import "CoreLocation/CoreLocation.h"
#import <MapKit/MapKit.h>

@interface EditPhotoViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate, UITextFieldDelegate>

@property(nonatomic, retain) IBOutlet UIImageView *imageView;
@property(nonatomic, retain) UIImagePickerController *picker2;
@property(nonatomic, retain) IBOutlet UIButton *gallery;

@property(nonatomic, retain) CLLocationManager *locationmanager;
@property(nonatomic, retain) IBOutlet CLLocationManager *locationManager;
@property(nonatomic, retain) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) IBOutlet UITextField *myTextField;


@property (strong, nonatomic) NSURL * imgPickerUrl;
@property (strong, nonatomic) NSURL *imageURL;

- (IBAction)galleryAction;
- (IBAction)geotagAction:(id)sender;
- (IBAction)viewAction:(id)sender;

- (IBAction)openURLAction:(id)sender;

@end

