//
//  MainViewContainer.h
//  CabFare
//
//  Created by Jin Jin on 10-11-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"
#import "ConfigViewController.h"

@interface MainViewContainer : UIViewController {

	MapViewController* _mapViewController;
	ConfigViewController* _configViewController;
	
	BOOL _pageCured;
	
	NSDate* _lastNotificationTime;
}

@property (nonatomic, retain) IBOutlet MapViewController* mapViewController;
@property (nonatomic, retain) IBOutlet ConfigViewController* configViewController;
@property (nonatomic, assign) BOOL pageCured;
@property (nonatomic, retain) NSDate* lastNotificationTime;

@end
