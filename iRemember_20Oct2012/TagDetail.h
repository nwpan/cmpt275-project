//
//  TagDetail.h
//  iRemember_20Oct2012
//
//  Created by Nicholas Pan on 10/20/12.
//  Copyright (c) 2012 Steven Tjendana. All rights reserved.
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
