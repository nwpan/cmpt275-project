//
//  User.h
//  iRemember
//
//  Created by Nicholas Pan on 2012-10-15.
//  Copyright (c) 2012 Group 11. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Session, Tag;

@interface User : NSManagedObject

@property (nonatomic, retain) NSDate * date_created;
@property (nonatomic, retain) NSString * first_name;
@property (nonatomic, retain) NSString * last_name;
@property (nonatomic, retain) NSNumber * user_id;
@property (nonatomic, retain) Session *session_fk;
@property (nonatomic, retain) Tag *tag_fk;

@end
