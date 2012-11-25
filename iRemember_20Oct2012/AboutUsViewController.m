/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * AboutUsViewController.m
 * iRemember_20Oct2012
 *
 * Created by Matt Numsen on 10/20/12.
 * Copyright (c) 2012 Double One. All rights reserved.
 *
 * Programmer: Matt Numsen
 * Team Name: Double One
 * Project Name: iRemember
 * Version: Version 1.0
 *
 * This view is about our team and project.
 *
 *
 * Changes:
 *   2012-10-20 Created
 *   2012-10-21 Add comments
 *   2012-11-24 Remove camera button on navigation bar
 *
 * Known bugs: No bugs found yet
 *
 *
 * Last revised on 2012-11-24
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
