//
//  CabFareForCity.m
//  CabFare
//
//  Created by Jin Jin on 10-10-9.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CabFareCity.h"

#define CITY_DICT @"cities"

@implementation CabFareCity

@synthesize country = _country;
@synthesize cityName = _cityName;
@synthesize startMileage = _startMileage;
@synthesize startFare = _startFare;
@synthesize overMileageList = _overMileageList;
@synthesize additionalFares = _additionalFares;
@synthesize location = _location;

static NSArray* countries = nil; 
static NSDictionary* cities = nil;

#pragma mark --
#pragma mark Class Methods

+(CabFareCity*)cityForName:(NSString*)city{
	
	NSDictionary* cities = [self supportedCities];
	
	return [cities objectForKey:city];
}

+(NSDictionary*)supportedCities{
	
	if (!cities){
		NSString* filePath = [[NSBundle mainBundle] pathForResource:CITY_DICT ofType:@"plist"];
		
		NSDictionary* rawCities = [NSDictionary dictionaryWithContentsOfFile:filePath];
		
		NSArray* keys = [rawCities allKeys];
		
		NSDictionary* rawCity = nil;
		
		NSMutableDictionary* m_cities = [NSMutableDictionary dictionary];
		
		for (NSString* key in keys){
			rawCity = [rawCities objectForKey:key];
			CabFareCity* cfCity = [[CabFareCity alloc] init];
			cfCity = [[CabFareCity alloc] init];
			cfCity.cityName = key;
			cfCity.country = [rawCity objectForKey:COUNTRY_KEY];
			cfCity.startFare = [rawCity objectForKey:START_FARE_KEY];
			cfCity.startMileage = [rawCity objectForKey:START_MILEAGE_KEY];
			cfCity.overMileageList = [rawCity objectForKey:OVER_MILEAGE_LIST_KEY];
			cfCity.additionalFares = [rawCity objectForKey:ADDITIONAL_FARES_KEY];
			CLLocation* loc = [[CLLocation alloc] initWithLatitude:[[rawCity objectForKey:LATITUDE_KEY] floatValue]
														 longitude:[[rawCity objectForKey:LONGTITUDE_KEY] floatValue]];
			cfCity.location = loc;
			[loc release];
			
			[m_cities setObject:cfCity forKey:key];
			
			[cfCity release];
		}
		cities = [m_cities retain];
	}
	
	return cities;
}

+(NSArray*)supportedCounties{
	if (!countries){
		NSDictionary* cities = [self supportedCities];
		
		NSMutableSet* countryname = [NSMutableSet setWithCapacity:0];
		
		NSEnumerator* enumerator = [cities objectEnumerator];
		
		CabFareCity* city = nil;
		
		while (city = [enumerator nextObject]) {
			[countryname addObject:city.country];
		}
		countries = [[countryname allObjects] retain];
	}
	
	return countries;
	
}

+(NSArray*)citiesForCountry:(NSString*)countryname{
	NSMutableArray* cityArray = [NSMutableArray arrayWithCapacity:0];
	NSDictionary* mcities = [self supportedCities];
	
	NSEnumerator* enumerator = [mcities objectEnumerator];
	
	CabFareCity* city = nil;
	
	while (city = [enumerator nextObject]) {
		if ([countryname isEqualToString:city.country]){
			[cityArray addObject:city];
		}
	}
	
	return cityArray;
	
}

//if the city is supported
+(BOOL)isSupportedCity:(NSString*)city{
	BOOL supported = NO;
	if ([self cityForName:city]){
		supported = YES;
	}
	
	return supported;
}

-(void)dealloc{
	[self.country release];
	[self.cityName release];
	[self.startMileage release];
	[self.startFare release];
	[self.overMileageList release];
	[self.additionalFares release];
	[self.location release];
	[super dealloc];
}

@end
