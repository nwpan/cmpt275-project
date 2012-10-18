//
//  TagDetail.h
//  iRemember
//
//  Created by Nicholas Pan on 2012-10-15.
//  Copyright (c) 2012 Group 11. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Tag, TagType;

@interface TagDetail : NSManagedObject

@property (nonatomic, retain) NSString * data;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * type_id;
@property (nonatomic, retain) TagType *type_fk;
@property (nonatomic, retain) Tag *tag_fk;

@end
