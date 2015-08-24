//
//  NSDate+CompareDates.m
//  l8
//
//  Created by Tudor Dragan on 22/4/15.
//  Copyright (c) 2015 Tudor Dragan. All rights reserved.
//

#import "NSDate+CompareDates.h"

@implementation NSDate (CompareDates)
+ (BOOL)isDate:(NSDate *)date inRangeFirstDate:(NSDate *)firstDate lastDate:(NSDate *)lastDate {
	return [date compare:firstDate] == NSOrderedDescending &&
	[date compare:lastDate]  == NSOrderedAscending;
}
@end
