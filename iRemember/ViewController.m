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


-(IBAction)save:(id)sender{

    //first string
    NSString *saveString = field1.text;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:saveString forKey:@"saveString"];
    [defaults synchronize];
    
    
    //second string
    NSString *saveString2 = field2.text;
    NSUserDefaults *defaults2 = [NSUserDefaults standardUserDefaults];
    [defaults2 setObject:saveString2 forKey:@"saveString2"];
    [defaults2 synchronize];
    
    
    //third string
    NSString *saveString3 = field3.text;
    NSUserDefaults *defaults3 = [NSUserDefaults standardUserDefaults];
    [defaults3 setObject:saveString3 forKey:@"saveString3"];
    [defaults3 synchronize];
    
    loaded.text = @"Saved String Succesfully";
}
-(IBAction)load:(id)sender{
    
    // first string load
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *loadString = [defaults objectForKey:@"saveString"];
    (field1 setText:loadString);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)viewDidUnload
{
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

@end
