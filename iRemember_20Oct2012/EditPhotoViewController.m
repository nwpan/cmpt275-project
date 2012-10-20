//
//  EditPhotoViewController.m
//  iRemember_20Oct2012
//
//  Created by Steven Tjendana on 10/20/12.
//  Copyright (c) 2012 Steven Tjendana. All rights reserved.
//

#import "EditPhotoViewController.h"
#import "SecondEditViewController.h"

@interface EditPhotoViewController ()

@end

@implementation EditPhotoViewController

@synthesize secondViewData;

-(IBAction)edit:(id)sender{
    SecondEditViewController *second = [[SecondEditViewController alloc]initWithNibName:nil bundle:nil];
    
    self.secondViewData = second;
    
    //UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    secondViewData.imagePassed = imageView.image;
    
    [self presentModalViewController:second animated:YES];
    
}


-(IBAction)gallery{
    picker2 = [[UIImagePickerController alloc]init];
    picker2.delegate = self;
    [picker2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentModalViewController:picker2 animated:YES];
}


-(IBAction) camera{
    
    picker2 = [[UIImagePickerController alloc]init];
    picker2.delegate = self;
    
    /*
     if (sc.selectedSegmentIndex == 0){
     [picker2 setSourceType:UIImagePickerControllerSourceTypeCamera];
     }else if (sc.selectedSegmentIndex == 1){
     [picker2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
     }*/
    
    [picker2 setSourceType:UIImagePickerControllerSourceTypeCamera];
    
    [self presentModalViewController:picker2 animated:YES];
    //[picker2 release];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [imageView setImage:image];
    
    [self dismissModalViewControllerAnimated:YES];
}



-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissModalViewControllerAnimated:YES];
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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //sc.selectedSegmentIndex = -1;
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
