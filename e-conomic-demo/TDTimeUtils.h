//
//  TDTimeUtils.h
//  l8
//
//  Created by Tudor Dragan on 16/4/15.
//  Copyright (c) 2015 Tudor Dragan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDTimeUtils : NSObject

+(NSDate*) roundUpDate:(NSDate*) date toTimeInterval:(NSInteger) minuteInterval;

+(NSInteger) dayOfWeekFromDate:(NSDate*) date;

+ (NSDate *)dateToNearest15MinutesForDate:(NSDate*)date;
@end
