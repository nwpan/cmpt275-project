//
//  fileIOController.m
//  iRemember
//
//  Created by Charles Shin on 10/19/12.
//  Copyright (c) 2012 Group 11. All rights reserved.
//

#import "fileIOController.h"

@implementation fileIOController


@synthesize filePaths, fileData, fileDataBuffer, fileManager, fileHandle;

-(NSData *) readTheFile:(NSString *)filePath
{
    /* This is path of iphone app local storage
    NSString *tempString = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES)objectAtIndex:0]; //
    NSString *result = [tempString stringByAppendingPathComponent:@"results.txt"]; //*/
    
    //filePath = @"output.txt";
    
    if([self isFileExist:filePath])
    {
        self.fileHandle = [NSFileHandle fileHandleForReadingAtPath:filePath];
        self.fileData = [fileHandle availableData];
        [fileHandle closeFile];
    }

    return fileData;

}
//NSString *result = [[NSString alloc] initWithData:[fileHandle availableData] encoding:NSUTF8StringEncoding];

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
    
    if(![self isFileExist:saveTo])
    {
        [[NSFileManager defaultManager] createFileAtPath:saveTo contents:nil attributes:nil];
    }    
    
    fileHandle = [NSFileHandle fileHandleForWritingAtPath:saveTo];
    [fileHandle truncateFileAtOffset:0];
    [fileHandle writeData:[textFrom dataUsingEncoding:NSUTF8StringEncoding]];
    [fileHandle closeFile];
    
}

-(NSData *)toDataBuffer
{
    return fileDataBuffer;
}


@end
