//
//  CabFareCalculator.m
//  CabFare
//
//  Created by Jin Jin on 10-10-9.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CabFareCalculator.h"
#import "CabFareCalculator_private.h"
#import "CabFareCity.h"

@implementation CabFareCalculator

-(NSNumber*)cabFare:(NSString*)city mileage:(NSNumber*)mileage time:(NSDate*)time{

	CabFareCity* ccFare = [CabFareCity cityForName:city];
	
	NSString* specailCalculatorName = [city stringByAppendingString:@"_fareCalculator:"];
	
	NSNumber* totalFare = nil;
	
	if ([self respondsToSelector:@selector(specailCalculatorName)]){
		NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:mileage, @"distance", time, @"time", nil];
		totalFare = [self performSelector:@selector(specailCalculatorName) withObject:parameters];
	}else {
		totalFare = [self commonCalculatorForCity:ccFare
										  mileage:mileage 
											 time:time];
	}

	
	return totalFare;
}

@end

@implementation CabFareCalculator (private)

-(NSNumber*)commonCalculatorForCity:(CabFareCity*)cityCabFare
							mileage:(NSNumber*)mileage 
							   time:(NSDate*)time{
	
	float startMileage = [cityCabFare.startMileage floatValue];
	float totalFare = [cityCabFare.startFare floatValue];
	
	float mileageFloat = [mileage floatValue];
	
	if (mileageFloat > startMileage){
		
		float previousMileage = startMileage;
		
		for (NSDictionary* overUnit in cityCabFare.overMileageList){
			float overFare = [[overUnit objectForKey:OVER_FARE_KEY] floatValue];
			float overMileage = [[overUnit objectForKey:OVER_MILEAGE_KEY] floatValue];
			
			
			if (mileageFloat <= previousMileage + overMileage){
				totalFare += (mileageFloat-previousMileage)*overFare;
				break;
			}else {
				totalFare += overMileage*overFare;
				previousMileage += overMileage;
			}
		}
	}
		
		
	return [NSNumber numberWithFloat:totalFare];
}

@end