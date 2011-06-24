//
//  MainViewContainer.m
//  CabFare
//
//  Created by Jin Jin on 10-11-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "MainViewContainer.h"

#define TIMEINTERVAL 0.5

@implementation MainViewContainer

@synthesize mapViewController = _mapViewController;
@synthesize configViewController = _configViewController;
@synthesize pageCured = _pageCured;
@synthesize lastNotificationTime = _lastNotificationTime;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

-(id)init{
	if (self = [super init]){
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchSubViews:)
													 name:NOTIFICATION_SWITCH_VIEWS
												   object:nil];
		DebugLog(@"init of MainViewContrainer");
		self.lastNotificationTime = [NSDate distantPast];
	}
	
	return self;
}

-(void)loadView{
	[[NSBundle mainBundle] loadNibNamed:@"MainViewContainer" owner:self options:nil];
	[self.view addSubview:self.configViewController.view];
	[self.view addSubview:self.mapViewController.view];
	DebugLog(@"load view of MainViewContrainer");
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.pageCured = NO;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark -
#pragma mark notification call back

-(void)switchSubViews:(NSNotification*)notification{
	[self performSelectorOnMainThread:@selector(switchSubViewsTask)
						   withObject:nil
						waitUntilDone:NO];
}

-(void)switchSubViewsTask{
	//mark the timestamp
	//avoid two notifications came in at almost same time
	NSDate* time = [NSDate date];
	
	NSTimeInterval interval = [time timeIntervalSinceDate:self.lastNotificationTime];
	
	DebugLog(@"interval is %.2f", interval);
	
	if (interval <= TIMEINTERVAL){//too close
		self.lastNotificationTime = time;
		return;
	}
	
	self.lastNotificationTime = time;
	
	DebugLog(@"switching sub views");
	
	CATransition *animation = [CATransition animation];
    [animation setDelegate:self];
    [animation setDuration:TIMEINTERVAL];
    [animation setTimingFunction:UIViewAnimationCurveEaseInOut];
	
	if (!self.pageCured){
		animation.type = @"pageCurl";
		animation.fillMode = kCAFillModeForwards;
		animation.endProgress = 0.58;
    } else {
        animation.type = @"pageUnCurl";
        animation.fillMode = kCAFillModeBackwards;
        animation.startProgress = 0.42;
    }
	self.pageCured = !self.pageCured;
	
	[animation setRemovedOnCompletion:NO];
	
	UIView* superView = self.view;	
	
	NSArray* subviews = self.view.subviews;
	
	for (UIView* v in subviews){
		DebugLog(@"add of view is %d", v);
	}
	
	[superView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
	
	[superView.layer addAnimation:animation forKey:@"pageCurlAnimation"];
	
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	self.mapViewController = nil;
	self.configViewController = nil;
	self.lastNotificationTime = nil;
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:NOTIFICATION_SWITCH_VIEWS 
												  object:nil];
    [super dealloc];
}


@end
