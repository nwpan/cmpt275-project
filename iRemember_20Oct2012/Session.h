//
//  Session.h
//  iRemember_20Oct2012
//
//  Created by Nicholas Pan on 10/20/12.
//  Copyright (c) 2012 Steven Tjendana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Session : NSManagedObject

@property (nonatomic, retain) NSNumber * session_id;
@property (nonatomic, retain) NSNumber * user_id;
@property (nonatomic, retain) User *user_fk;

@end
