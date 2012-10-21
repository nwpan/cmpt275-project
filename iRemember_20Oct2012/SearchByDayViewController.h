//
//  SearchByDayViewController.h
//  iRemember_20Oct2012
//
//  Created by Matt Numsen on 10/20/12.
//  Copyright (c) 2012 Steven Tjendana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchByDayViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UIDatePicker *datePicker;
    UILabel *label;
}
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
-(IBAction) getSelection;

@end
