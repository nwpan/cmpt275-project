//
//  Tag.h
//  iRemember
//
//  Created by Nicholas Pan on 10/20/12.
//  Copyright (c) 2012 Group 11. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TagDetail, User;

@interface Tag : NSManagedObject

@property (nonatomic, retain) NSNumber * detail_id;
@property (nonatomic, retain) NSNumber * user_id;
@property (nonatomic, retain) TagDetail *detail_fk;
@property (nonatomic, retain) User *user_fk;

@end
