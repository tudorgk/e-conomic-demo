//
//  TimeInterval.h
//  e-conomic-demo
//
//  Created by Tudor Dragan on 24/8/15.
//  Copyright (c) 2015 tudordev.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Project;

@interface TimeInterval : NSManagedObject

@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) Project *project;

@end
