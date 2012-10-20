//
//  openURLViewController.m
//  iRemember_20Oct2012
//
//  Created by Steven Tjendana on 10/20/12.
//  Copyright (c) 2012 Steven Tjendana. All rights reserved.
//

#import "openURLViewController.h"

@interface openURLViewController ()

@end

@implementation openURLViewController

-(IBAction)refresh:(id)sender{
    [webView loadRequest:[NSURLRequest requestWithURL: [NSURL URLWithString: @"http://www.google.com"]]];
}

-(IBAction)search:(id)sender{
    NSString *query = [searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", query]];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    [webView loadRequest:request];
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self refresh:self];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
