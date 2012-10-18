//
//  Tag.h
//  iRemember
//
//  Created by Nicholas Pan on 2012-10-15.
//  Copyright (c) 2012 Group 11. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Tag : NSManagedObject

@property (nonatomic, retain) NSNumber * detail_id;
@property (nonatomic, retain) NSNumber * user_id;
@property (nonatomic, retain) NSManagedObject *detail_fk;

@end
