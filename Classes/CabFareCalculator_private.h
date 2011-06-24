//
//  CabFareCalculator(private).h
//  CabFare
//
//  Created by Jin Jin on 10-10-9.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CabFareCity.h"

@interface CabFareCalculator (private)

-(NSNumber*)commonCalculatorForCity:(CabFareCity*)cityCabFare mileage:(NSNumber*)mileage time:(NSDate*)time;

@end
