//
//  TDCoreDataManager.h
//  e-conomic-demo
//
//  Created by Tudor Dragan on 21/8/15.
//  Copyright (c) 2015 tudordev.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Project.h"
#import "TimeInterval.h"

@interface TDCoreDataManager : NSObject

+(TDCoreDataManager*) sharedInstance;

-(void) addNewProjectToDatabaseWithName:(NSString*) projectName
							 andDetails:(NSString*) details;
-(void) removeProjectFromDatabase:(Project*) projectEntity;

-(void) addTimeIntervalToProject:(Project*) project
								 withTitle:(NSString*) title
								startDate:(NSDate*) startDate
							   andEndDate:(NSDate*) endDate;
-(void) removeTimeInterval:(TimeInterval*) timeInterval;

@end
