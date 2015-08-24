//
//  AppDelegate.m
//  e-conomic-demo
//
//  Created by Tudor Dragan on 21/8/15.
//  Copyright (c) 2015 tudordev.com. All rights reserved.
//

#import "AppDelegate.h"
#import <MagicalRecord/MagicalRecord.h>
#import <CocoaLumberjack/CocoaLumberjack.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
@interface AppDelegate ()

@end



@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.
	
	//initialize stuff!
	[self configureLogger];
	
	[self setUpMagicalRecord];
	
	[self setUpKeyboardManager];
	
	[self setAppearenceProxies];
	
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.

	//This tidies up after MagicalRecord
	[MagicalRecord cleanUp];
}

#pragma mark - Setup Magical Record

-(void) setUpMagicalRecord{
	
	[MagicalRecord setupCoreDataStackWithStoreNamed:@"e-conomic-model.xcdata"];
	
}

#pragma mark - Configure logger

-(void) configureLogger{
	// Enable XcodeColors
	setenv("XcodeColors", "YES", 0);
	
	// Standard lumberjack initialization
	[DDLog addLogger:[DDTTYLogger sharedInstance]];
	
	// And then enable colors
	[[DDTTYLogger sharedInstance] setColorsEnabled:YES];
	
	[[DDTTYLogger sharedInstance] setForegroundColor:[UIColor blueColor] backgroundColor:nil forFlag:DDLogFlagInfo];
	[[DDTTYLogger sharedInstance] setForegroundColor:[UIColor orangeColor] backgroundColor:nil forFlag:DDLogFlagDebug];
	[[DDTTYLogger sharedInstance] setForegroundColor:[UIColor greenColor] backgroundColor:nil forFlag:DDLogFlagVerbose];

	DDLogInfo(@"logger initialized!");
	
}

#pragma mark - set up visuals

-(void) setUpKeyboardManager{
	[[IQKeyboardManager sharedManager ] setEnable:YES ];
	[[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
	[[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:60];
}

-(void) setAppearenceProxies{
	NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
								[UIColor whiteColor], NSForegroundColorAttributeName,
								[UIFont fontWithName:@"Avenir-Heavy" size:17], NSFontAttributeName, nil];
	
	
	[[UINavigationBar appearanceWhenContainedIn:[UINavigationController class], nil] setBarTintColor:[UIColor colorWithRed:101.0f/255.0f green:79.0f/255.0f blue:155.0f/255.0f alpha:1]];
	[[UIBarButtonItem appearanceWhenContainedIn:[UINavigationController class], nil] setTintColor:[UIColor whiteColor]];
	[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
	[[UINavigationBar appearanceWhenContainedIn:[UINavigationController class], nil] setTitleTextAttributes:attributes];
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

}

@end
