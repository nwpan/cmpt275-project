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

@interface EditPhotoViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate>{
    
    //IBOutlet UISegmentedControl *sc;
    IBOutlet UIImageView *imageView;
    UIImagePickerController *picker2;
    IBOutlet UIButton *gallery;
    CLLocationManager *locationmanager;
    
    SecondEditViewController *secondViewData;
    
    
}

@property(nonatomic, retain)SecondEditViewController *secondViewData;
@property (retain, nonatomic) IBOutlet CLLocationManager *locationManager;
@property (retain, nonatomic) IBOutlet MKMapView *mapView;
-(IBAction)camera;
-(IBAction)gallery;
-(IBAction)edit;
- (IBAction)geotag:(id)sender;
- (IBAction)view:(id)sender;


@end

