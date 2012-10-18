//
//  Session.h
//  iRemember
//
//  Created by Nicholas Pan on 2012-10-15.
//  Copyright (c) 2012 Group 11. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Session : NSManagedObject

@property (nonatomic, retain) NSNumber * session_id;
@property (nonatomic, retain) NSNumber * user_id;
@property (nonatomic, retain) User *user_fk;

@end
