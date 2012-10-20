//
//  LoginViewController.m
//  iRemember
//
//  Created by Nicholas Pan on 2012-10-14.
//  Copyright (c) 2012 Group 11. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"

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
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        //[self initUser];
    }
    @catch (NSException *exception)
    {
        lblStatus.text = [exception reason];
        return;
    }
    
    NSManagedObjectContext *context = [app managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSError *error;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    [request setEntity:entity];
    
    NSArray *arr = [context executeFetchRequest:request error:&error];
    
    for (User *u in arr)
    {
        NSLog(@"First name, %@", u.first_name);
        NSLog(@"Last name, %@", u.last_name);
        NSLog(@"User id, %@", u.user_id);
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Success! Cake for everyone!" delegate:self cancelButtonTitle:@"Hide" otherButtonTitles:nil];
    [alert show];
    lblStatus.text = @"Success!";
}

- (void)initUser
{
    NSManagedObjectContext *context = [app managedObjectContext];

    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];

    user.last_name = nil;
    user.first_name = nil;
    user.user_id = [self generateUuidString];
    
    NSException *exception;
    NSError *error;
    if (![context save:&error])
    {
        NSLog(@"Something went wrong.");
        exception = [NSException exceptionWithName: @"CoreData Save Exception"
                                            reason: @"Something went wrong."
                                          userInfo: nil];
        @throw exception;
    }

    /*
     NSManagedObjectContext *context = [app managedObjectContext];
     NSFetchRequest *request = [[NSFetchRequest alloc] init];
     NSError *error;
     NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
     [request setEntity:entity];
     
     NSArray *arr = [context executeFetchRequest:request error:&error];
     
     for (User *u in arr)
     {
     NSLog(@"First name, %@", u.first_name);
     NSLog(@"Last name, %@", u.last_name);
     NSLog(@"User id, %@", u.user_id);
     }
     */
    
}

@end
