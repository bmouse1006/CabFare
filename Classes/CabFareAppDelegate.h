//
//  CabFareAppDelegate.h
//  CabFare
//
//  Created by Jin Jin on 10-10-9.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestWindow.h"
#import "MapViewController.h"
#import "MainViewContainer.h"

@interface CabFareAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	
	TestWindow* _testWindow;
	
	MainViewContainer* _viewContainer;
	
	UINavigationController* _navController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) TestWindow* testWindow;
@property (nonatomic, retain) MainViewContainer* viewContainer;
@property (nonatomic, retain) UINavigationController* navController;

@end

