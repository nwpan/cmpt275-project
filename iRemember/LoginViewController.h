//
//  LoginViewController.h
//  iRemember
//
//  Created by Nicholas Pan on 2012-10-14.
//  Copyright (c) 2012 Group 11. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface LoginViewController : UIViewController

@property (nonatomic, retain) AppDelegate *app;

@property (nonatomic, retain) IBOutlet UIButton *btnStart;
@property (nonatomic, retain) IBOutlet UILabel *lblStatus;

-(IBAction) btnStartAction:(id) sender;
-(NSString *) generateUuidString;

@end
