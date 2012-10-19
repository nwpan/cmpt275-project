//
//  LoginViewController.h
//  iRemember
//
//  Created by Nicholas Pan on 2012-10-14.
//  Copyright (c) 2012 Group 11. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface LoginViewController : UIViewController

-(IBAction) btnRegister:(id) sender;

@property (nonatomic, retain) AppDelegate *app;

@end
