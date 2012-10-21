//
//  MainMenuViewController.m
//  iRemember_20Oct2012
//
//  Created by Steven Tjendana on 10/20/12.
//  Copyright (c) 2012 Steven Tjendana. All rights reserved.
//

#import "MainMenuViewController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController


-(IBAction)gallery{
    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
    picker.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsImageEditing = YES;
    [[self navigationController] presentModalViewController:picker animated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [self performSegueWithIdentifier:@"yoloSegue" sender:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:[defaults objectForKey:@"user_id"] delegate:self cancelButtonTitle:@"Hide" otherButtonTitles:nil];
    [alert show];
    
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
