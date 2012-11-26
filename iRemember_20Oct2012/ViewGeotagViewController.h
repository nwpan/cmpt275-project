//
//  ViewGeotagViewController.h
//  iRemember
//
//  Created by Jake Nagazine on 11/11/12.
//  Copyright (c) 2012 Double One. All rights reserved.
//
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * Programmer:Jake Nagazine
 * Team Name: Double One
 * Project Name: iRemember
 * Version: Version 1.0
 *
 * Display map.
 *
 *
 * Changes:
 *   2012-11-11 Created
 *
 * Known bugs: Not yet found
 *
 *
 * Last revised on 2012-11-24
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CoreLocation/CoreLocation.h"

@interface ViewGeotagViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet CLLocationManager *locationmanager;
@property (nonatomic) MKCoordinateRegion region;

@end
