//
//  Project.h
//  e-conomic-demo
//
//  Created by Tudor Dragan on 24/8/15.
//  Copyright (c) 2015 tudordev.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TimeInterval;

@interface Project : NSManagedObject

@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *timeInterval;
@end

@interface Project (CoreDataGeneratedAccessors)

- (void)addTimeIntervalObject:(TimeInterval *)value;
- (void)removeTimeIntervalObject:(TimeInterval *)value;
- (void)addTimeInterval:(NSSet *)values;
- (void)removeTimeInterval:(NSSet *)values;

@end
