//
//  openURLViewController.h
//  iRemember_20Oct2012
//
//  Created by Steven Tjendana on 10/20/12.
//  Copyright (c) 2012 Steven Tjendana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface openURLViewController : UIViewController <UITextFieldDelegate>  {
    IBOutlet UIWebView *webView;
    IBOutlet UITextField *searchBar;
}

-(IBAction)refresh:(id)sender;
-(IBAction)search:(id)sender;

-(IBAction)goBackMenu:(id)sender;


@end
