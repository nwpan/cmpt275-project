//
//  ViewController.h
//  iRemember
//
//  Created by Nicholas Pan on 10/1/12.
//  Copyright (c) 2012 Group 11. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id) sender;

@property (nonatomic, retain) IBOutlet UIView *LoginView;

@end
