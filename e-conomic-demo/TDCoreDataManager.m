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

-(Project *) addNewProjectToDatabaseWithName:(NSString *)projectName andDetails:(NSString *)details{

	//for letting the application create the project even when
	//it's shoved in the background ^^
	UIApplication *application = [UIApplication sharedApplication];
	
	__block UIBackgroundTaskIdentifier bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
		[application endBackgroundTask:bgTask];
		bgTask = UIBackgroundTaskInvalid;
	}];

	
	//first validate the strings
	if ([projectName validateAlphanumericSpace] && [details validateAlphanumericSpace]) {
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
			
			// add it if not with response value of 0
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
	
	return nil;
	
	
	
}

-(void) removeProjectFromDatabase:(Project *)projectEntity{

}

@end
