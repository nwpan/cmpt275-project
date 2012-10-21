//
//  fileIOController.h
//  iRemember
//
//  Created by Charles Shin on 10/19/12.
//  Copyright (c) 2012 Group 11. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface fileIOController : NSObject

@property (nonatomic, strong) NSFileManager *fileManager;
@property (nonatomic, strong) NSString *filePaths;
@property (nonatomic, strong) NSData *fileData;
@property (nonatomic, strong) NSData *fileDataBuffer;
@property (nonatomic, strong) NSFileHandle *fileHandle;

-(NSData *) readTheFile:(NSString *)filePath;
-(BOOL) isFileExist:(NSString *)filePath;
-(void) writeOnTheFile:(NSString *) saveTo dataFrom: (NSString *) textFrom;
-(NSData *)toDataBuffer;


@end