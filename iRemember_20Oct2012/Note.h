//
//  Note.h
//  iRemember
//
//  Created by Jake Nagazine on 11/11/12.
//  Copyright (c) 2012 Double One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Image;

@interface Note : NSManagedObject

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * image_id;
@property (nonatomic, retain) Image *images;

@end
