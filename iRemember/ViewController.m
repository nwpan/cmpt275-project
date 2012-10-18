//
//  ViewController.m
//  iRemember
//
//  Created by Nicholas Pan on 10/1/12.
//  Copyright (c) 2012 Group 11. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize sampleLabel;
@synthesize sampleLabel2;
@synthesize locationManager;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    self.sampleLabel.text = @"Good bye cruel world.";
    self.sampleLabel2.text = @"Hello again!";
}

- (void)viewDidUnload
{
    [self setLocationManager:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)locationManager:(CLLocationManager *)manager
didUpdateToLocation:(CLLocation *)newLocation
fromLocation:(CLLocation *)oldLocation
{

    [manager stopUpdatingLocation];
    
    NSLog(@"- Latitude: %f\n", newLocation.coordinate.latitude);
    NSLog(@"- Longitude: %f\n", newLocation.coordinate.longitude);
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMM d yyyy, K:mm a, z"];
    
    NSDate *now = [[NSDate alloc] init];
    
    NSString *dateString = [format stringFromDate: now];
    
    NSLog(@"- Timestamp: %@\n", dateString);
    
    
}

- (IBAction)GeoTag:(id)sender {
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
}
@end
