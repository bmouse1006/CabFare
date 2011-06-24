//
//  MapViewController.m
//  CabFare
//
//  Created by Jin Jin on 10-10-16.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "UserPreferenceDefine.h"
#import "CityPickerViewController.h"

@implementation MapViewController

@synthesize currentCity = _currentCity;
@synthesize savedCity = _savedCity;
@synthesize locationManager = _locationManager;
@synthesize mapView = _mapView;
@synthesize picker = _picker;
@synthesize switchNotifyViewController = _switchNotifyViewController;

#pragma mark -
#pragma mark view life cycle
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
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
	//register city selected notification
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(newCitySelected:) 
												 name:CITY_SELECTED_NOTIFICATION
											   object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(changeMapStyle:)
												 name:NOTIFICATION_SWITCH_MAP_STYLE
											   object:nil];
	//get default city
//	self.mapView.showsUserLocation = YES;
	CabFareCity* defaultCity = [CabFareCity cityForName:[UserPreferenceDefine defaultCity]];
	[self showMapForCity:defaultCity shouldNotify:NO];
	
	//get current location
	[self startGetCurrentLocation];
	
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	self.mapView = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


#pragma mark -
#pragma mark predefined methods

-(void)showMapForCity:(CabFareCity*)city shouldNotify:(BOOL)notify{
	//if should notify user that the map is switching city, show the notify view
	//this view will show and last for 3 sec, and disappeared in 0.5 sec after that
	[self showSwitchNotifyView:city];
	//if city is nil, do nothing
	if (city){
		//get location for city
		MKCoordinateRegion region;
		region.center = city.location.coordinate;
		MKCoordinateSpan span = {0.05, 0.05};
		region.span = span;
		[self.mapView setRegion:region animated:YES];
	}
}

-(void)showSwitchNotifyView:(CabFareCity*)city{
	if (!self.switchNotifyViewController){
		CitySwitchNotifyViewController* controller = [[CitySwitchNotifyViewController alloc] initWithNibName:@"CitySwitchNotifyViewController" bundle:nil];
		self.switchNotifyViewController = controller;
		[controller release];
	}
	
//	self.switchNotifyViewController.cityName = self.currentCity;
//	self.switchNotifyViewController.view.center = self.view.center;
//	[self.view addSubview:self.switchNotifyViewController.view];
}

-(void)startGetCurrentLocation{
	if (!self.locationManager){
		
		CLLocationManager* manager = [[CLLocationManager alloc] init];
		manager.delegate = self;
		self.locationManager = manager;
		[manager release];
		[self.locationManager startUpdatingLocation];
	}
}

-(CabFareCity*)nearestCityFromLocation:(CLLocation*)location{
	//calculate distance to dicide which is the closest one
	NSDictionary* cities = [CabFareCity supportedCities];
	
	NSEnumerator* enu = [cities objectEnumerator];
	
	CabFareCity* city = nil;
	CabFareCity* nearestCity = nil;
	CLLocationDistance distance = NSUIntegerMax;
	
	while (city = [enu nextObject]) {
		CLLocationDistance tempDis = [location distanceFromLocation:city.location];
		if (tempDis < distance){
			distance = distance;
			nearestCity = city;
		}
	}
	
	return nearestCity;
}

-(void)switcAndShowCity:(CabFareCity*)city{
	//save city as deafult city
	[UserPreferenceDefine setDefaultCity:city.cityName];
	//show a view to tell user that default city has been changed
	
	//show city in map
	[self showMapForCity:city shouldNotify:YES];
}

-(IBAction)showPicker:(id)sender{
	self.picker = nil;
	CityPickerViewController* cityPicker = [[CityPickerViewController alloc] init];
	[self.view addSubview:cityPicker.view];
	self.picker = cityPicker;
	[cityPicker release];
	[self.picker presentAnimated:YES];
}

-(IBAction)showConfigView:(id)sender{
	
	NSNotification* notification = [NSNotification notificationWithName:@"switchMapViewAndConfigView" object:nil];
	
	[[NSNotificationCenter defaultCenter] postNotification:notification];
	
}

-(void)newCitySelected:(NSNotification *)notification{
	CabFareCity* selectedCity = [notification.userInfo objectForKey:SELECTED_CITY_KEY];
	
	if (selectedCity && ![selectedCity.cityName isEqualToString:self.currentCity]){
		
		NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:selectedCity, @"city", [NSNumber numberWithInt:YES], @"notify", nil];
		
		[self performSelectorOnMainThread:@selector(showMapForCity:) 
							   withObject:parameters 
							waitUntilDone:NO];
		[UserPreferenceDefine setDefaultCity:selectedCity.cityName];
	}
}

-(void)showMapForCity:(NSDictionary*)parameters{
	
	CabFareCity* city = [parameters objectForKey:@"city"];
	NSNumber* notify = [parameters objectForKey:@"notify"];
	
	[self showMapForCity:city shouldNotify:[notify intValue]];
	
}

#pragma mark -
#pragma mark delegate methods
//delegate methods for location manager
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
	DebugLog(@"MapViewContoller: did receive update to location");
	if (self.locationManager == manager){
		//stop locating after get a location
		[self.locationManager stopUpdatingLocation];
		
		CabFareCity* nearestCity = [self nearestCityFromLocation:newLocation];
		CabFareCity* defaultCity = [CabFareCity cityForName:[UserPreferenceDefine defaultCity]];
		
		if (![defaultCity.cityName isEqualToString:nearestCity.cityName]){
			[self switcAndShowCity:nearestCity];
		}
	}
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
	DebugLog(@"MapViewContoller: location managerdid receive error");
}

//delegate methods for Reverse Geocoder
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark{
	DebugLog(@"MapViewContoller: geocoder did Find Placemark");
	DebugLog(@"country is %@", placemark.country);
	DebugLog(@"admin is %@", placemark.administrativeArea);
	DebugLog(@"sub admin is %@", placemark.subAdministrativeArea);
	DebugLog(@"locality is %@", placemark.locality);
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error{
	DebugLog(@"MapViewContoller: geocoder did Faile with error");
}

#pragma mark -
#pragma mark call back for notification
-(void)changeMapStyle:(id)sender{
	DebugLog(@"changing map style");
	NSNotification* notification = (NSNotification*)sender;
	
	NSString* mapStyle = [notification.userInfo objectForKey:NOTIFICATION_MAP_STYLE];
	
	DebugLog(@"style is %@", mapStyle);
	
	MKMapType type = MKMapTypeStandard;
	
	if ([mapStyle isEqualToString:NOTIFICATION_MAP_STYLE_STANDARD]){
		type = MKMapTypeStandard;
	}else if ([mapStyle isEqualToString:NOTIFICATION_MAP_STYLE_SATELLITE]){
		type = MKMapTypeSatellite;
	}else if ([mapStyle isEqualToString:NOTIFICATION_MAP_STYLE_HYBRID]){
		type = MKMapTypeHybrid;
	}
	
	self.mapView.mapType = type;
}

- (void)dealloc {
	//remove observer
	[[NSNotificationCenter defaultCenter] removeObserver:self 
													name:CITY_SELECTED_NOTIFICATION
												  object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self 
													name:NOTIFICATION_SWITCH_MAP_STYLE
												  object:nil];
	//release objects
	[self.currentCity release];
	[self.savedCity release];
	[self.mapView release];
	[self.picker release];
	[self.locationManager release];
	[self.switchNotifyViewController release];
    [super dealloc];
}


@end
