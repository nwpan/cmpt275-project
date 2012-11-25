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
#import <MapKit/MapKit.h>
#import "ViewGeotagViewController.h"
#import "CoreLocation/CoreLocation.h"

@interface EditPhotoViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate, UITextFieldDelegate, UITabBarDelegate, UITextViewDelegate>

@property(nonatomic, retain) CLLocationManager *locationmanager;
@property(nonatomic, retain) IBOutlet CLLocationManager *locationManager;
@property(nonatomic, retain) IBOutlet MKMapView *mapView;

//Appearance
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *drawingView;
@property(nonatomic, retain) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (strong, nonatomic) IBOutlet UITabBar *tabBar;
@property (strong, nonatomic) UITabBarItem *tagTabBarItem;
@property (strong, nonatomic) UITabBarItem *noteTabBarItem;
@property (strong, nonatomic) UITabBarItem *drawTabBarItem;
@property (strong, nonatomic) NSArray *tabItems;
@property (strong, nonatomic) UIBarButtonItem *cameraBarButtonItem;


@property (strong, nonatomic) UIImage *myImage;
@property (strong, nonatomic) NSURL *imageURL;

@property (strong, nonatomic) NSString *textFieldString;
@property (strong, nonatomic) UITextField *saveField;
@property (weak, nonatomic) IBOutlet UIButton *updateGeotagAction;

- (void)geotagAction;
- (IBAction)viewAction:(id)sender;
- (IBAction) alert;


@end

