//
//  TagType.h
//  iRemember
//
//  Created by Nicholas Pan on 2012-11-10.
//  Copyright (c) 2012 Double One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TagDetail;

@interface TagType : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) TagDetail *detail_fk;

@end
