//
//  CabFareForCity.h
//  CabFare
//
//  Created by Jin Jin on 10-10-9.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define START_FARE_KEY			@"startFare"
#define START_MILEAGE_KEY		@"startMileage"
#define OVER_MILEAGE_LIST_KEY	@"overMileageList"
#define OVER_FARE_KEY			@"overFare"
#define OVER_MILEAGE_KEY		@"overMileage"
#define ADDITIONAL_FARES_KEY	@"additionalFares"
#define COUNTRY_KEY				@"country"
#define CITY_NAME_KEY			@"cityName"
#define LATITUDE_KEY			@"latitude"
#define LONGTITUDE_KEY			@"longtitude"

@interface CabFareCity : NSObject {
	NSString* _country;
	NSString* _cityName;
	NSNumber* _startMileage;
	NSNumber* _startFare;
	NSArray* _overMileageList;
	NSArray* _additionalFares;
	CLLocation* _location;
}

@property (nonatomic, retain) NSString* country;
@property (nonatomic, retain) NSString* cityName;
@property (nonatomic, retain) NSNumber* startMileage;
@property (nonatomic, retain) NSNumber* startFare;
@property (nonatomic, retain) NSArray* overMileageList;
@property (nonatomic, retain) NSArray* additionalFares;
@property (nonatomic, retain) CLLocation* location;

+(CabFareCity*)cityForName:(NSString*)city;
+(NSDictionary*)supportedCities;
+(NSArray*)supportedCounties;
+(NSArray*)citiesForCountry:(NSString*)countryname;
+(BOOL)isSupportedCity:(NSString*)city;

@end
