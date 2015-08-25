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

+(NSDateComponents *)differenceBetweenStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate{
	NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
	NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute
														fromDate:startDate
														  toDate:endDate
														 options:0];
	return components;
}

+(NSString*) stringDifferenceBetweenStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate{
	NSDateComponents * diffComp = [TDTimeUtils differenceBetweenStartDate:startDate andEndDate:endDate];
	NSMutableString * returnString = [NSMutableString new];
	
	if (diffComp.day!=0) {
		[returnString appendFormat:@"%dd",diffComp.day];
	}
	
	if (diffComp.hour !=0) {
		[returnString appendFormat:@"%dh",diffComp.hour];
	}
	
	if (diffComp.minute !=0) {
		[returnString appendFormat:@"%dm",diffComp.minute];
	}
	
	NSLog(@"return String = %@", returnString);
	
	return [returnString description];
	
}

+(NSTimeInterval) calculateElapsedTimeForTwoDates:(NSDate*) startDate andEndDate:(NSDate*) endDate;{
	NSTimeInterval distanceBetweenDates = [endDate timeIntervalSinceDate:startDate];
	return distanceBetweenDates;
}

+(NSString*) stringFromTimeInterval:(NSTimeInterval) timeInterval{
	NSInteger ti = (NSInteger)timeInterval;
	NSInteger minutes = (ti / 60) % 60;
	NSInteger hours = (ti / 3600) % 24;
	NSInteger days = (ti / (3600 * 24));
	
	return [NSString stringWithFormat:@"%ldd%ldh%ldm", (long)days, (long)hours, (long)minutes];
}



@end
