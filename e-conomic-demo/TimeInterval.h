//
//  TimeInterval.h
//  e-conomic-demo
//
//  Created by Tudor Dragan on 21/8/15.
//  Copyright (c) 2015 tudordev.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface TimeInterval : NSManagedObject

@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSManagedObject *project;
@property (nonatomic, retain) NSString * title;
@end
