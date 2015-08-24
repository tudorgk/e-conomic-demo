//
//  TDTimeUtils.m
//  l8
//
//  Created by Tudor Dragan on 16/4/15.
//  Copyright (c) 2015 Tudor Dragan. All rights reserved.
//

#import "TDTimeUtils.h"

@implementation TDTimeUtils

+(NSDate*) roundUpDate:(NSDate *)date toTimeInterval:(NSInteger)minuteInterval{
	NSDateComponents *comps = [[NSCalendar currentCalendar] components: NSCalendarUnitEra|NSCalendarUnitYear| NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitTimeZone fromDate: date];

	NSUInteger remainder = ([comps minute] % minuteInterval);
	if (remainder < minuteInterval/2)
		date = [date dateByAddingTimeInterval:-60 * remainder];
	else
		date = [date dateByAddingTimeInterval:60 * (10 - remainder)];
	return date;
}

+ (NSDate *)dateToNearest15MinutesForDate:(NSDate*)date {
	// Set up flags.
	unsigned unitFlags = NSCalendarUnitEra|NSCalendarUnitYear| NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitTimeZone | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekday;
	// Extract components.
	NSDateComponents *comps = [[NSCalendar currentCalendar] components:unitFlags fromDate:date];
	// Set the minute to the nearest 15 minutes.
	[comps setMinute:((([comps minute] - 8 ) / 15 ) * 15 ) + 15];
	// Zero out the seconds.
	[comps setSecond:0];
	// Construct a new date.
	return [[NSCalendar currentCalendar] dateFromComponents:comps];
}

+(NSInteger) dayOfWeekFromDate:(NSDate *)date{
	// 1 -> 7, Sunday = 1;
	
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:date];
	return components.weekday;

}
@end
