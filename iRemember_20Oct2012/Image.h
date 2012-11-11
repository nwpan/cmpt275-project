//
//  Image.h
//  iRemember
//
//  Created by Nicholas Pan on 2012-11-10.
//  Copyright (c) 2012 Double One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Geotag, Note, Tag;

@interface Image : NSManagedObject

@property (nonatomic, retain) NSString * image_path;
@property (nonatomic, retain) Geotag *geotags;
@property (nonatomic, retain) Note *notes;
@property (nonatomic, retain) Tag *tags;

@end
