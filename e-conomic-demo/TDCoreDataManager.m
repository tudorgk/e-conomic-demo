//
//  TDCoreDataManager.m
//  e-conomic-demo
//
//  Created by Tudor Dragan on 21/8/15.
//  Copyright (c) 2015 tudordev.com. All rights reserved.
//

#import "TDCoreDataManager.h"
#import <MagicalRecord/MagicalRecord.h>
#import "NSString+StringValidation.h"

static TDCoreDataManager *sharedInstance = nil;

@implementation TDCoreDataManager

-(id) init{
	self = [super init];
	if (self){
		
	}
	return self;
}

+ (TDCoreDataManager *)sharedInstance{
	if(!sharedInstance)
		sharedInstance = [[TDCoreDataManager alloc] init];
	
	return sharedInstance;
}

-(void) addNewProjectToDatabaseWithName:(NSString *)projectName andDetails:(NSString *)details{

	//for letting the application create the project even when
	//it's shoved in the background ^^
	UIApplication *application = [UIApplication sharedApplication];
	
	__block UIBackgroundTaskIdentifier bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
		[application endBackgroundTask:bgTask];
		bgTask = UIBackgroundTaskInvalid;
	}];

	
	//first validate the strings
	if ([projectName validateAlphanumericSpace] &&
		[projectName validateNotEmpty] && [details validateNotEmpty]) {
		//if both strings are valid, proceed
		
		//for letting the application create the project even when
		//it's shoved in the background ^^
		UIApplication *application = [UIApplication sharedApplication];
		
		__block UIBackgroundTaskIdentifier bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
			[application endBackgroundTask:bgTask];
			bgTask = UIBackgroundTaskInvalid;
		}];
		
		[MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
			// this will occur on a background thread
			
			//create the new project entity
			Project *newProject = [Project MR_createEntityInContext:localContext];
			newProject.name = projectName;
			newProject.details = details;
			
		}completion:^(BOOL success, NSError *error) {
			if (success) {
				DDLogInfo(@"Project saved successful!");
				
				//post notification of database change
				[[NSNotificationCenter defaultCenter] postNotificationName:TDDatabaseDidChangeNotification object:self];
				
			}else{
				DDLogError(@"Project did not save with error = %@", [error description]);
			}
			
			[application endBackgroundTask:bgTask];
			bgTask = UIBackgroundTaskInvalid;
		}];
	}

}

-(void) removeProjectFromDatabase:(Project *)projectEntity{
	//for letting the application remove the project even when
	//it's shoved in the background ^^
	UIApplication *application = [UIApplication sharedApplication];
	
	__block UIBackgroundTaskIdentifier bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
		[application endBackgroundTask:bgTask];
		bgTask = UIBackgroundTaskInvalid;
	}];
	
	[MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
		// this will occur on a background thread
		
		[projectEntity MR_deleteEntity];
		
		}completion:^(BOOL success, NSError *error) {
		if (success) {
			DDLogInfo(@"Project deleted successful!");
			
			//post notification of database change
			[[NSNotificationCenter defaultCenter] postNotificationName:TDDatabaseDidChangeNotification object:self];
			
		}else{
			DDLogError(@"Project did not delete with error = %@", [error description]);
		}
		
		[application endBackgroundTask:bgTask];
		bgTask = UIBackgroundTaskInvalid;
	}];

}

-(void) addTimeIntervalToProject:(Project *)project withTitle:(NSString *)title startDate:(NSDate *)startDate andEndDate:(NSDate *)endDate{
	//for letting the application create the project even when
	//it's shoved in the background ^^
	UIApplication *application = [UIApplication sharedApplication];
	
	__block UIBackgroundTaskIdentifier bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
		[application endBackgroundTask:bgTask];
		bgTask = UIBackgroundTaskInvalid;
	}];
	
	
	//first validate the strings
	if ([title validateAlphanumericSpace] && [title validateNotEmpty]) {
		//if both strings are valid, proceed
		
		//for letting the application create the time interval even when
		//it's shoved in the background ^^
		UIApplication *application = [UIApplication sharedApplication];
		
		__block UIBackgroundTaskIdentifier bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
			[application endBackgroundTask:bgTask];
			bgTask = UIBackgroundTaskInvalid;
		}];
		
		[MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
			// this will occur on a background thread
			
			//create the new project entity
			TimeInterval* newTimeInterval = [TimeInterval MR_createEntityInContext:localContext];
			newTimeInterval.startDate = startDate;
			newTimeInterval.endDate = endDate;
			newTimeInterval.title=title;
			newTimeInterval.project = project;
			
		}completion:^(BOOL success, NSError *error) {
			if (success) {
				DDLogInfo(@"Time interval saved successful!");
				
				//post notification of database change
				[[NSNotificationCenter defaultCenter] postNotificationName:TDDatabaseDidChangeNotification object:self];
				
			}else{
				DDLogError(@"Time interval did not save with error = %@", [error description]);
			}
			
			[application endBackgroundTask:bgTask];
			bgTask = UIBackgroundTaskInvalid;
		}];
	}
	
}

-(void) removeTimeInterval:(TimeInterval *)timeInterval{
	//for letting the application remove the time interval even when
	//it's shoved in the background ^^
	UIApplication *application = [UIApplication sharedApplication];
	
	__block UIBackgroundTaskIdentifier bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
		[application endBackgroundTask:bgTask];
		bgTask = UIBackgroundTaskInvalid;
	}];
	
	[MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
		// this will occur on a background thread
		
		[timeInterval MR_deleteEntity];
		
	}completion:^(BOOL success, NSError *error) {
		if (success) {
			DDLogInfo(@"Time interval deleted successful!");
			
			//post notification of database change
			[[NSNotificationCenter defaultCenter] postNotificationName:TDDatabaseDidChangeNotification object:self];
			
		}else{
			DDLogError(@"Time interval did not delete with error = %@", [error description]);
		}
		
		[application endBackgroundTask:bgTask];
		bgTask = UIBackgroundTaskInvalid;
	}];

}

@end
