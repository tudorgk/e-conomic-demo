//
//  TDTimeIntervalValidator.h
//  e-conomic-demo
//
//  Created by Tudor Dragan on 24/8/15.
//  Copyright (c) 2015 tudordev.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Project.h"
typedef enum{
	TDTimeIntervalAssertionValid,
	TDTimeIntervalAssertionInvalid
} TDTimeIntervalAssertion;

@interface TDTimeIntervalValidator : NSObject

+(TDTimeIntervalAssertion) validateTimeIntervalWithStartDate:(NSDate*) startDate
													 endDate:(NSDate*) endDate
												  forProject:(Project*) project;

@end
