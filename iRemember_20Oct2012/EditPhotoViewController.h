//
//  EditPhotoViewController.h
//  iRemember_20Oct2012
//
//  Created by Steven Tjendana on 10/20/12.
//  Copyright (c) 2012 Steven Tjendana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondEditViewController.h"
#import "CoreLocation/CoreLocation.h"
#import <MapKit/MapKit.h>

@interface EditPhotoViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate> 

@property(nonatomic, retain) IBOutlet UIImageView *imageView;
@property(nonatomic, retain) UIImagePickerController *picker2;
@property(nonatomic, retain) IBOutlet UIButton *gallery;
@property(nonatomic, retain) CLLocationManager *locationmanager;

@property(nonatomic, retain) SecondEditViewController *secondViewData;
@property(nonatomic, retain) IBOutlet CLLocationManager *locationManager;
@property(nonatomic, retain) IBOutlet MKMapView *mapView;

- (IBAction)galleryAction;
- (IBAction)editAction;
- (IBAction)geotagAction:(id)sender;
- (IBAction)viewAction:(id)sender;

@end

