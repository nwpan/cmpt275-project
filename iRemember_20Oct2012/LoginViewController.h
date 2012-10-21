//
//  LoginViewController.h
//  iRemember_20Oct2012
//
//  Created by Nicholas Pan on 10/20/12.
//  Copyright (c) 2012 Steven Tjendana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "User.h"

@interface LoginViewController : UIViewController

@property (nonatomic, retain) AppDelegate *app;

@property (nonatomic, retain) IBOutlet UIButton *btnStart;
@property (nonatomic, retain) IBOutlet UILabel *lblStatus;

-(IBAction) btnStartAction:(id) sender;
-(NSString *) generateUuidString;

@end
