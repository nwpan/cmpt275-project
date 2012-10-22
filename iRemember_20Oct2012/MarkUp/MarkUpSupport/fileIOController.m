/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * fileIOController.m
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

#import "fileIOController.h"

@implementation fileIOController


@synthesize fileData, fileManager, fileHandle;

-(NSData *) readTheFile:(NSString *)filePath
{
    
    if([self isFileExist:filePath]) //if file exist, read the file data
    {
        self.fileHandle = [NSFileHandle fileHandleForReadingAtPath:filePath];
        self.fileData = [fileHandle availableData];
        [fileHandle closeFile];
    }

    return fileData;

}

-(BOOL) isFileExist:(NSString *)filePath
{
    fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath: filePath ] == YES)
       return YES;
    else
        return NO;
}

-(void) writeOnTheFile:(NSString *)saveTo dataFrom:(NSString *)textFrom
{
    
    if(![self isFileExist:saveTo]) //if file does not exist at the path, create a file. 
    {
        [[NSFileManager defaultManager] createFileAtPath:saveTo contents:nil attributes:nil];
    }    
    
    fileHandle = [NSFileHandle fileHandleForWritingAtPath:saveTo];
    [fileHandle truncateFileAtOffset:0];
    [fileHandle writeData:[textFrom dataUsingEncoding:NSUTF8StringEncoding]];
    [fileHandle closeFile];
    
}



@end
