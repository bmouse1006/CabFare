//
//  MapViewController.h
//  CabFare
//
//  Created by Jin Jin on 10-10-16.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJMapView.h"
#import "CabFareCity.h"
#import "CityPickerViewController.h"
#import "ConfigViewController.h"
#import "CitySwitchNotifyViewController.h"

@interface MapViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate, MKReverseGeocoderDelegate> {

	NSString* _currentCity;
	NSString* _savedCity;
	
	JJMapView* _mapView;
	
	CLLocationManager* _locationManager;
	
	CityPickerViewController* _picker;
	
	CitySwitchNotifyViewController* _switchNotifyViewController;
}

@property (nonatomic, retain) NSString* currentCity;
@property (nonatomic, retain) NSString* savedCity;
@property (nonatomic, retain) CLLocationManager* locationManager;
@property (nonatomic, retain) IBOutlet JJMapView* mapView;
@property (nonatomic, retain) CityPickerViewController* picker;
@property (nonatomic, retain) CitySwitchNotifyViewController* switchNotifyViewController;

-(void)showMapForCity:(CabFareCity*)city shouldNotify:(BOOL)notify;
-(void)startGetCurrentLocation;
-(CabFareCity*)nearestCityFromLocation:(CLLocation*)location;
-(void)switcAndShowCity:(CabFareCity*)city;

-(IBAction)showPicker:(id)sender;
-(IBAction)showConfigView:(id)sender;
-(void)showSwitchNotifyView:(CabFareCity*)city;
-(void)newCitySelected:(NSNotification*)notification;

@end
