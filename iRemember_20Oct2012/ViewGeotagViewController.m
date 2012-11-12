//
//  ViewGeotagViewController.m
//  iRemember
//
//  Created by Jake Nagazine on 11/11/12.
//  Copyright (c) 2012 Double One. All rights reserved.
//


#import "ViewGeotagViewController.h"


@interface ViewGeotagViewController ()

@end

@implementation ViewGeotagViewController
@synthesize mapView;
@synthesize locationmanager;
@synthesize region;

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
    [mapView setRegion:region animated:YES];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [self setLocationmanager:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
