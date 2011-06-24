//
//  CityPickerViewController.h
//  CabFare
//
//  Created by Jin Jin on 10-10-23.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SELECTED_CITY_KEY @"selectedCity"
#define CITY_SELECTED_NOTIFICATION @"cityselected"

@interface CityPickerViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource> {
	
	UIPickerView* _picker;
	UIToolbar* _toolBar;
	UIBarButtonItem* _cancelButton;
	UIBarButtonItem* _doneButton;
	NSArray* _countries;
	NSArray* _citiesForCurrentCountry;
	
	NSString* _selectedCountry;
}

@property (nonatomic, retain) IBOutlet UIPickerView* picker;
@property (nonatomic, retain) IBOutlet UIToolbar* toolBar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem* cancelButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem* doneButton;
@property (nonatomic, retain) NSArray* countries;
@property (nonatomic, retain) NSArray* citiesForCurrentCountry;
@property (nonatomic, retain) NSString* selectedCountry;

-(void)presentAnimated:(BOOL)animated;
-(void)setViewsToInitialStatus;

-(void)dismissAnimated:(BOOL)animated;
-(void)localizeUI;

-(IBAction)cancelButtonTouched;
-(IBAction)doneButtonTouched;

@end
