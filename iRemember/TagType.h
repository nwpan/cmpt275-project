//
//  TagType.h
//  iRemember
//
//  Created by Nicholas Pan on 10/20/12.
//  Copyright (c) 2012 Group 11. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TagDetail;

@interface TagType : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) TagDetail *detail_fk;

@end
