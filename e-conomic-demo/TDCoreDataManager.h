//
//  TDCoreDataManager.h
//  e-conomic-demo
//
//  Created by Tudor Dragan on 21/8/15.
//  Copyright (c) 2015 tudordev.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Project.h"

@interface TDCoreDataManager : NSObject

+(TDCoreDataManager*) sharedInstance;

-(Project*) addNewProjectToDatabaseWithName:(NSString*) projectName andDetails:(NSString*) details;
-(void) removeProjectFromDatabase:(Project*) projectEntity;


@end
