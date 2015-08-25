//
//  TDTimeIntervalValidator.m
//  e-conomic-demo
//
//  Created by Tudor Dragan on 24/8/15.
//  Copyright (c) 2015 tudordev.com. All rights reserved.
//

#import "TDTimeIntervalValidator.h"
#import "TimeInterval.h"
#import <MagicalRecord/MagicalRecord.h>
#import "NSDate+CompareDates.h"
@implementation TDTimeIntervalValidator

-(id) init{
	self = [super init];
	if (self) {
		
	}
	return self;
}

/*
	fetch all stored project intervals
	check if start date or end date is in one of those intervals
	if so return TDTimeIntervalAssertionInvalid
 */
+(TDTimeIntervalAssertion) validateTimeIntervalWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate forProject:(Project *)project{
	
	NSArray* projectTimeIntervals = [TimeInterval MR_findByAttribute:@"project" withValue:project andOrderBy:@"startDate" ascending:YES];

	//sanity check project
	if (project == nil) {
		return TDTimeIntervalAssertionInvalid;
	}
	
	//sanity check dates
	if ([TDTimeIntervalValidator validateStartDate:startDate andEndDate:endDate] == NO) {
		return TDTimeIntervalAssertionInvalid;
	}
	
	//check if the dates are in
	for (TimeInterval * ti in projectTimeIntervals) {
		if ([NSDate isDate:startDate inRangeFirstDate:ti.startDate lastDate:ti.endDate] ||
			[NSDate isDate:endDate inRangeFirstDate:ti.startDate lastDate:ti.endDate] ||
			[ti.startDate isEqualToDate:startDate] || [ti.endDate isEqualToDate:endDate]) {
			return TDTimeIntervalAssertionInvalid;
		}
	}
	
	return TDTimeIntervalAssertionValid;
}

+(BOOL) validateStartDate:(NSDate*) startDate andEndDate:(NSDate*) endDate{
	//check if they are nil
	if (startDate ==nil || endDate == nil) {
		return NO;
	}
	
	NSComparisonResult result = [startDate compare:endDate];
	
	switch (result)
	{
		case NSOrderedAscending:{
			return YES;
		}
			break;
		case NSOrderedSame:{
			return YES;
		}
			break;
		default:
			return NO;
			break;
	}
	
}

@end
