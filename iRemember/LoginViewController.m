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

- (IBAction) btnRegister:(id) sender {
    [self.view removeFromSuperview];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        app = [[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void) createData
{
    NSManagedObjectContext *context = [app managedObjectContext];

    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];

    user.last_name = @"Test";
    user.first_name = @"Test123";

    NSError *error;
    if (![context save:&error])
    {
        NSLog(@"Something went wrong.");
    }

}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    [self createData];
    
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
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
