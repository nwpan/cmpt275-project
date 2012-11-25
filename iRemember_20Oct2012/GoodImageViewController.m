//
//  GoodImageViewController.m
//  iRemember
//
//  Created by Jake Nagazine on 11/17/12.
//  Copyright (c) 2012 Double One. All rights reserved.
//

#import "GoodImageViewController.h"

@interface GoodImageViewController ()

@end

@implementation GoodImageViewController

@synthesize selectedWord;

NSArray *uniqueImagePathArray;
NSURL *selectedURL;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSSet *uniqueImages;
    NSMutableArray *sortedImagePath = [[NSMutableArray alloc] init];
    if (selectedWord != nil)
    {
        NSArray *tagsWithWord = [Tag MR_findByAttribute:@"word" withValue: selectedWord];
        
        for (int i=0; i<[tagsWithWord count]; i++)
        {
            [sortedImagePath addObject: ((Tag*)[tagsWithWord objectAtIndex:i]).image_path];
        }
    }
    else
    {
        NSArray *images = [Image MR_findAllSortedBy:@"_pk" ascending:YES];
        for (int i=0; i<[images count]; i++)
        {
            [sortedImagePath addObject: ((Image*)[images objectAtIndex:i]).image_path];
        }
        
    }
    uniqueImages = [NSSet setWithArray: sortedImagePath];
    uniqueImagePathArray = [uniqueImages allObjects];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [uniqueImagePathArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // Configure the cell...
    cell.textLabel.text = [uniqueImagePathArray objectAtIndex:indexPath.row];
    __block UIImage *image;
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    
    
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *rep = [myasset defaultRepresentation];
        CGImageRef iref = [rep fullResolutionImage];
        if (iref) {
            image = [UIImage imageWithCGImage:iref];
            [cell.imageView setImage:image];
            [cell.imageView setFrame:CGRectMake(0, 0, 44, 44)];
            [cell.textLabel setFrame:CGRectMake(44, 0, 276, 44)];
        }
        
    };
    
    //
    ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror)
    {
        NSLog(@"booya, cant get image - %@",[myerror localizedDescription]);
    };
    NSURL *url = [[NSURL alloc] initWithString:[uniqueImagePathArray objectAtIndex:indexPath.row]];
    [assetslibrary assetForURL:url
                   resultBlock:resultblock
                  failureBlock:failureblock];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedURL = [[NSURL alloc] initWithString:[uniqueImagePathArray objectAtIndex:[indexPath row]]];
    [self performSegueWithIdentifier:@"selectedImageSegue" sender:self];
}

/* Pass the URL of the selected image to the EditPhotoViewController */
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"selectedImageSegue"])
    {
        EditPhotoViewController *editPhoto = [segue destinationViewController];
        editPhoto.imageURL = selectedURL;
    }
}

@end
