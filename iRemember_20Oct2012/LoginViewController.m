/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * LoginViewController.m
 * iRemember_20Oct2012
 *
 * Created by Nicholas Pan on 10/20/12.
 * Copyright (c) 2012 Double One. All rights reserved.
 *
 * Programmer: Nicholas Pan
 * Team Name: Double One
 * Project Name: iRemember
 * Version: Version 1.0
 *
 * This manages a user who uses this application. 
 * Due to impairment of our target users, memory impairment, 
 * the application will not asks for login ID and password.
 * However, each user will be assigned with a unique id which will be hidden to user.
 *
 * Changes:
 *   2012-10-20 Created
 *   2012-10-21 Add comments
 *
 * Known bugs: No bugs
 *
 *
 * Last revised on 2012-10-21
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize app;
@synthesize btnStart;
@synthesize lblStatus;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
         app = [[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSManagedObjectContext *context = [app managedObjectContext];
	if (context == nil)
    {
        context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
        NSLog(@"After managedObjectContext: %@",  context);
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        if ([[defaults objectForKey:@"user_id"] length] != 0)
            [self performSegueWithIdentifier:@"yoloSegue" sender:self];
        
    }
}

/*
 * Generates a UUID string for us to use as USER_ID.
 */
- (NSString *) generateUuidString
{
    // create a new UUID which you own
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    
    // create a new CFStringRef.
    NSString *uuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuid));
    
    // release the UUID
    CFRelease(uuid);
    
    return uuidString;
}

- (IBAction)btnStartAction:(id) sender
{
    /*
     * Initialize user data through Core Data.
     */
    lblStatus.text = @"Initializing user data.";
    [btnStart setEnabled:NO];
    
    @try
    {
        [self initUser];
    }
    @catch (NSException *exception)
    {
        lblStatus.text = [exception reason];
        return;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Success! Continue to the main menu." delegate:self cancelButtonTitle:@"Hide" otherButtonTitles:nil];
    [alert show];
    lblStatus.text = @"Success in user creation.";
    [self performSegueWithIdentifier:@"yoloSegue" sender:self];
}

- (void)initUser
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"first_name"];
    [defaults setObject:nil forKey:@"last_name"];
    [defaults setObject:[self generateUuidString] forKey:@"user_id"];
    [defaults synchronize];
    NSLog(@"User data saved");
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
