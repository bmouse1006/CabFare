//
//  CabFareAppDelegate.m
//  CabFare
//
//  Created by Jin Jin on 10-10-9.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CabFareAppDelegate.h"
#import "TestWindow.h"
#import "MapViewController.h"

@implementation CabFareAppDelegate

@synthesize window;

@synthesize testWindow = _testWindow;
@synthesize viewContainer = _viewContainer;
@synthesize navController = _navController;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    
	TestWindow* temp = [[TestWindow alloc] init];
	self.testWindow = temp;
	[temp release];
	
	MainViewContainer* vcontainer = [[MainViewContainer alloc] init];
	self.viewContainer = vcontainer;
	[vcontainer release];
	
	UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:self.viewContainer];
	[nav setNavigationBarHidden:YES];
	self.navController = nav;
	[nav release];
//	[window addSubview:self.testWindow.view];
	[window addSubview:self.navController.view];
//	[window addSubview:self.viewContainer.view];
    [window makeKeyAndVisible];
	
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
	[[NSUserDefaults standardUserDefaults] synchronize];
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
	[self.testWindow release];
	[self.viewContainer release];
	[self.navController release];
    [super dealloc];
}


@end
