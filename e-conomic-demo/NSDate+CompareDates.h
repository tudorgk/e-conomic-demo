//
//  NSDate+CompareDates.h
//  l8
//
//  Created by Tudor Dragan on 22/4/15.
//  Copyright (c) 2015 Tudor Dragan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CompareDates)
+ (BOOL)isDate:(NSDate *)date inRangeFirstDate:(NSDate *)firstDate lastDate:(NSDate *)lastDate;
@end
