//
//  TagDetail.h
//  iRemember
//
//  Created by Nicholas Pan on 2012-11-10.
//  Copyright (c) 2012 Double One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Tag, TagType;

@interface TagDetail : NSManagedObject

@property (nonatomic, retain) NSString * data;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * type_id;
@property (nonatomic, retain) Tag *tag_fk;
@property (nonatomic, retain) TagType *type_fk;

@end
