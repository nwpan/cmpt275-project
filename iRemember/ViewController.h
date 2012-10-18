//
//  ViewController.h
//  iRemember
//
//  Created by Nicholas Pan on 10/1/12.
//  Copyright (c) 2012 Group 11. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>
{
    CLLocationManager *locationmanager;
}

@property(weak, nonatomic) IBOutlet UILabel *sampleLabel;

@property(weak, nonatomic) IBOutlet UILabel *sampleLabel2;
@property (strong, nonatomic) IBOutlet CLLocationManager *locationManager;
- (IBAction)GeoTag:(id)sender;

@end
