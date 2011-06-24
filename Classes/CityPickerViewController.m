//
//  CityPickerViewController.m
//  CabFare
//
//  Created by Jin Jin on 10-10-23.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CityPickerViewController.h"
#import "CabFareCity.h"
#import "UserPreferenceDefine.h"

@implementation CityPickerViewController

@synthesize picker = _picker;
@synthesize toolBar = _toolBar;
@synthesize cancelButton = _cancelButton;
@synthesize doneButton = _doneButton;
@synthesize countries = _countries;
@synthesize citiesForCurrentCountry = _citiesForCurrentCountry;
@synthesize selectedCountry = _selectedCountry;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

-(void)viewDidLoad{

	self.picker.delegate = self;
	self.picker.dataSource = self;
	
	CabFareCity* city = [CabFareCity cityForName:[UserPreferenceDefine defaultCity]];
	self.countries = [CabFareCity supportedCounties];
	if ([self.countries count]){
		
		if (city){
			self.selectedCountry = city.country;
		}else {
			self.selectedCountry = [self.countries objectAtIndex:0];
		}

		self.citiesForCurrentCountry = [CabFareCity citiesForCountry:self.selectedCountry];
	}
	
	[self setViewsToInitialStatus];
	
	[self.picker reloadAllComponents];
	//select current country and city
	[self.picker selectRow:[self.countries indexOfObject:self.selectedCountry]
			   inComponent:0
				  animated:NO];
	[self.picker selectRow:[self.citiesForCurrentCountry indexOfObject:city.cityName]
			   inComponent:1 
				  animated:NO];
	[self localizeUI];
}

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

-(void)setViewsToInitialStatus{
	self.view.backgroundColor = [UIColor clearColor];
	CGRect pickerRect = self.picker.frame;
	CGRect toolBarRect = self.toolBar.frame;
	
	toolBarRect.origin.y = 460;
	pickerRect.origin.y = toolBarRect.origin.y + toolBarRect.size.height;
	
	self.picker.frame = pickerRect;
	self.toolBar.frame = toolBarRect;
}

-(void)presentAnimated:(BOOL)animated{
	
	if (animated){
		[UIView beginAnimations:@"pickerviewshow" context:self];
	}
	
	//dim back ground
	self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
	
	//move up toolbar and picker view
	CGRect pickerRect = self.picker.frame;
	CGRect toolBarRect = self.toolBar.frame;
	
	pickerRect.origin.y = 460 - pickerRect.size.height;
	toolBarRect.origin.y = pickerRect.origin.y - toolBarRect.size.height;
	
	self.picker.frame = pickerRect;
	self.toolBar.frame = toolBarRect;
	
	if (animated){
		[UIView commitAnimations];
	}
	
}

-(void)dismissAnimated:(BOOL)animated{
	if (animated){
		[UIView beginAnimations:@"pickerviewdismiss" context:self];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	}
	
	[self setViewsToInitialStatus];
	
	if (animated){
		[UIView commitAnimations];
	}
	
}
		 
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{
	[self.view removeFromSuperview];
}

-(void)localizeUI{
	
}

#pragma mark -
#pragma mark call back methods for buttons
-(IBAction)cancelButtonTouched{
	[self dismissAnimated:YES];
}

-(IBAction)doneButtonTouched{
	//send notification to tell current city has been changed
	//map view will receive this notification
	CabFareCity* selectedCity = [self.citiesForCurrentCountry objectAtIndex:[self.picker selectedRowInComponent:1]];
	
	NSMutableDictionary* userInfo = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[userInfo setObject:selectedCity forKey:SELECTED_CITY_KEY];
	
	//create notification
	NSNotification* notification = [NSNotification notificationWithName:CITY_SELECTED_NOTIFICATION 
																 object:self 
															   userInfo:userInfo];
	//post notification
	[[NSNotificationCenter defaultCenter] postNotification:notification];
	
	[self dismissAnimated:YES];
}

#pragma mark -
#pragma mark delegate methods for picker view
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	switch (component) {
		case 0:
			if (![self.selectedCountry isEqualToString:[self.countries objectAtIndex:row]]){
				self.selectedCountry = [self.countries objectAtIndex:row];
				self.citiesForCurrentCountry = [CabFareCity citiesForCountry:self.selectedCountry];
				[self.picker reloadComponent:1];
			}
			break;
		case 1:
			//selected city
			//do nothing
			break;
		default:
			break;
	}
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	NSString* title = nil;
	switch (component) {
		case 0:
			title = [self.countries objectAtIndex:row];
			break;
		case 1:
			title = ((CabFareCity*)[self.citiesForCurrentCountry objectAtIndex:row]).cityName;
			break;
		default:
			break;
	}
	return NSLocalizedString(title, nil);
}

#pragma mark -
#pragma mark delegate methods for picker's data source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	NSInteger nb = 0;
	switch (component) {
		case 0:
			nb = [self.countries count];
			break;
		case 1:
			nb = [self.citiesForCurrentCountry count];
			break;
		default:
			break;
	}
	return nb;
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
	[self.picker release];
	[self.toolBar release];
	[self.cancelButton release];
	[self.doneButton release];
	[self.countries release];
	[self.citiesForCurrentCountry release];
	[self.selectedCountry release];
    [super dealloc];
}


@end
