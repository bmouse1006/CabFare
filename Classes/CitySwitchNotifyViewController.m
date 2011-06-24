//
//  CitySwitchNotifyViewController.m
//  CabFare
//
//  Created by Jin Jin on 10-11-22.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CitySwitchNotifyViewController.h"


@implementation CitySwitchNotifyViewController

@synthesize switchLabel = _switchLabel;
@synthesize cityNameLabel = _cityNameLabel;
@synthesize cityName = _cityName;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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

-(void)setCityName:(NSString *)name{
	if (self.cityName != name){
		[_cityName release];
		_cityName = name;
		[_cityName retain];
	}
	
	self.cityNameLabel.text = NSLocalizedString(self.cityName, nil);
	
	//adjust label width and view width

//	CGRect fontSize = [self.cityName.text sizeWithFont:[UIFont fontSize:
	
	//adjust view of frame: should this funtion to be moved to map view controller?
}

- (void)dealloc {
	self.switchLabel = nil;
	self.cityNameLabel = nil;
	self.cityName = nil;
    [super dealloc];
}


@end
