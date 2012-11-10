//
//  Tag.h
//  iRemember
//
//  Created by Nicholas Pan on 2012-11-10.
//  Copyright (c) 2012 Double One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Tag : NSManagedObject

@property (nonatomic, retain) NSNumber * image_id;
@property (nonatomic, retain) NSString * word;

@end
