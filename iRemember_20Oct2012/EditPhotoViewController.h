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

@interface EditPhotoViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate>{
    
    //IBOutlet UISegmentedControl *sc;
    IBOutlet UIImageView *imageView;
    UIImagePickerController *picker2;
    IBOutlet UIButton *gallery;
    
    SecondEditViewController *secondViewData;
    
    
}

@property(nonatomic, retain)SecondEditViewController *secondViewData;
@property (retain, nonatomic) IBOutlet CLLocationManager *locationManager;
-(IBAction)camera;
-(IBAction)gallery;
-(IBAction)edit;
- (IBAction)geotag:(id)sender;


@end

