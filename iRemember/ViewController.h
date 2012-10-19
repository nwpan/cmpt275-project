//
//  ViewController.h
//  iRemember
//
//  Created by Nicholas Pan on 10/1/12.
//  Copyright (c) 2012 Group 11. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

{
 
    IBOutlet UITextField *field1;
    IBOutlet UITextField *field2;
    IBOutlet UITextField *field3;
    IBOutlet UILabel *label1;
    
}

//database actions
-(IBAction)save:(id)sender;
-(IBAction)load:(id)sender;

//keyboard dismisses
-(IBAction)dismiss1:(id)sender;
-(IBAction)dismiss2:(id)sender;
-(IBAction)dismiss3:(id)sender;


@end
