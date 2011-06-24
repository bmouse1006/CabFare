//
//  ConfigViewController.m
//  CabFare
//
//  Created by Jin Jin on 10-10-24.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ConfigViewController.h"


@implementation ConfigViewController

@synthesize mapStyle = _mapStyle;
@synthesize autoSwitchLabel = _autoSwitchLabel;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self localizeUI];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

//switch to map view after touch ends (no metter what event is)
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	DebugLog(@"sending switch notification - touchesEnded");
	[self switchMapAndConfigView:nil];
}


-(IBAction)switchMapAndConfigView:(id)sender{
	
	NSNotification* notification = [NSNotification notificationWithName:NOTIFICATION_SWITCH_VIEWS object:nil];
	
	[[NSNotificationCenter defaultCenter] postNotification:notification];
	
}

-(IBAction)changeMapViewStyle:(id)sender{
	DebugLog(@"send notification to change map style");
	NSString* style = nil;
	switch(self.mapStyle.selectedSegmentIndex){
		case 0:
			style = NOTIFICATION_MAP_STYLE_STANDARD;
			break;
		case 1:
			style = NOTIFICATION_MAP_STYLE_SATELLITE;
			break;
		case 2:
			style = NOTIFICATION_MAP_STYLE_HYBRID;
			break;
		default:
			break;
	}
	
	NSDictionary* userInfo = [NSDictionary dictionaryWithObjectsAndKeys:style, NOTIFICATION_MAP_STYLE, nil];
	NSNotification* notification = [NSNotification notificationWithName:NOTIFICATION_SWITCH_MAP_STYLE 
																 object:nil 
															   userInfo:userInfo];
	[[NSNotificationCenter defaultCenter] postNotification:notification];
	[self switchMapAndConfigView:nil];
}

-(IBAction)setAutoSwitchCity:(id)sender{
	DebugLog(@"sending switch notification - setAutoSwitchCity");
	[self switchMapAndConfigView:nil];
}

-(void)localizeUI{
	DebugLog(@"localize UI");
	self.autoSwitchLabel.text = NSLocalizedString(self.autoSwitchLabel.text, nil);
	
	int nb = self.mapStyle.numberOfSegments;
	
	for (int i = 0; i<nb; i++){
		[self.mapStyle setTitle:NSLocalizedString([self.mapStyle titleForSegmentAtIndex:i], nil) 
			  forSegmentAtIndex:i];
	}
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
	self.mapStyle = nil;
	self.autoSwitchLabel = nil;
    [super dealloc];
}


@end
