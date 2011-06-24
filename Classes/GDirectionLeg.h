//
//  GDirectionLeg.h
//  CabFare
//
//  Created by Jin Jin on 10-10-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDirectionLocation.h"
#import "GDirectionReadableValue.h"

@interface GDirectionLeg : NSObject {

	NSArray* _steps;
	GDirectionReadableValue* _distance;
	GDirectionReadableValue* _duration;
	
	GDirectionLocation* _startLocation;
	GDirectionLocation* _endLocation;
	
	NSString* _startAddress;
	NSString* _endAddress;
	
}

@property (nonatomic, retain) NSArray* steps;
@property (nonatomic, retain) GDirectionReadableValue* distance;
@property (nonatomic, retain) GDirectionReadableValue* duration;
@property (nonatomic, retain) GDirectionLocation* startLocation;
@property (nonatomic, retain) GDirectionLocation* endLocation;
@property (nonatomic, retain) NSString* startAddress;
@property (nonatomic, retain) NSString* endAddress;

-(id)initWithJSONUnit:(NSDictionary*)unit;

@end
