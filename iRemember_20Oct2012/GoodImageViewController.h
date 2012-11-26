//
//  GoodImageViewController.h
//  iRemember
//
//  Created by Jake Nagazine on 11/17/12.
//  Copyright (c) 2012 Double One. All rights reserved.
//
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
* Programmer:Nicholas Pan, Jake Nagazine
* Team Name: Double One
* Project Name: iRemember
* Version: Version 1.0
*
* View recently viewed images
*
*
* Changes:
*   2012-11-17 Created
*
* Known bugs: Not yet found
*
*
* Last revised on 2012-11-24
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/


#import <UIKit/UIKit.h>
#import "GoodImageViewController.h"
#import "Tag.h"
#import "Image.h"
#import "EditPhotoViewController.h"

@interface GoodImageViewController : UITableViewController

@property (strong, nonatomic) NSString *selectedWord;


@end
