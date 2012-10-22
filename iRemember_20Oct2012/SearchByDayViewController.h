/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * SearchByDayViewController.h
 * iRemember_20Oct2012
 *
 * Created by Matt Numsen on 10/20/12.
 * Copyright (c) 2012 Double One. All rights reserved.
 *
 * Programmer: Matt Numsen
 * Team Name: Double One
 * Project Name: iRemember
 * Version: Version 1.0
 *
 * This manages search of photos. It will search photos with date given by a user.
 * 
 *
 * Changes:
 *   2012-10-20 Created
 *   2012-10-21 Add comments
 *
 * Know bugs: No bugs
 *
 *
 * Last revised on 2012-10-21
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

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
