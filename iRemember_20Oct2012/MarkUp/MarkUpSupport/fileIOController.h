/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* fileIOController.h
* iRemember
*
* Created by Charles Shin on 10/19/12.
* Copyright (c) 2012 Group 11. All rights reserved.
*
* Programmer: Charles Shin
* Team Name: Double One
* Project Name: iRemember
* Version: Version 1.0 
*
* This object manages reading and writing of a file.
* It will also checks if the file exist in the given path.
* When reading a file, a user will provide the path of the file to read from.
* When writing a file, a user will provide the path of the file to write to.
* The name of the file and its extension must be included in the path.
* File path example: /Users/User/Desktop/sampleProject/example.txt
*
*
* Changes: 
*   2012-10-19 Created
*   2012-10-20 Modify return type of readTheFile to NSData from NSString
*   2012-10-21 Add comments
*   
* Know bugs: No bugs
*
* Last revised on 2012-10-21
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

#import <Foundation/Foundation.h>

@interface fileIOController : NSObject


@property (nonatomic, strong) NSFileManager *fileManager;
@property (nonatomic, strong) NSData *fileData;
@property (nonatomic, strong) NSFileHandle *fileHandle;

/* read the file in filePath given by the user. The filepath must include filename and extension.
   File path example: /Users/User/Desktop/sampleProject/example.txt
   Also filepath has to be in string format. If file given by filepath exist, it will read the contents
   of the file and return them as NSData format.
 */
-(NSData *) readTheFile:(NSString *)filePath;

/* This method checks if the file exist in the given filepath.
 */
-(BOOL) isFileExist:(NSString *)filePath;

/* This method gets string format data and write it into the file given by the user.
 */
-(void) writeOnTheFile:(NSString *) saveTo dataFrom: (NSString *) textFrom;


@end