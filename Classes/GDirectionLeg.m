//
//  GDirectionLeg.m
//  CabFare
//
//  Created by Jin Jin on 10-10-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GDirectionLeg.h"
#import "GDirectionStep.h"
#import "GDirectionReadableValue.h"

@implementation GDirectionLeg

@synthesize steps = _steps;
@synthesize distance = _distance;
@synthesize duration = _duration;
@synthesize startLocation = _startLocation;
@synthesize endLocation = _endLocation;
@synthesize startAddress = _startAddress;
@synthesize endAddress = _endAddress;

-(id)initWithJSONUnit:(NSDictionary*)unit{
	if (self = [super init]){
		GDirectionReadableValue* tempDistance = [[GDirectionReadableValue alloc] initWithJSONUnit:[unit objectForKey:@"distance"]];
		self.distance = tempDistance;
		[tempDistance release];
		
		GDirectionReadableValue* tempDuration = [[GDirectionReadableValue alloc] initWithJSONUnit:[unit objectForKey:@"duration"]];
		self.duration = tempDuration;
		[tempDuration release];
		
		NSMutableArray* tempSteps = [NSMutableArray arrayWithCapacity:0];
		for (NSDictionary* stepUnit in [unit objectForKey:@"steps"]){
			GDirectionStep* step = [[GDirectionStep alloc] initWithJSONUnit:stepUnit];
			[tempSteps addObject:step];
			[step release];
		}
		self.steps = tempSteps;
		
		GDirectionLocation* start = [[GDirectionLocation alloc] initWithJSONUnit:[unit objectForKey:@"start_location"]];
		self.startLocation = start;
		[start release];
		
		GDirectionLocation* end = [[GDirectionLocation alloc] initWithJSONUnit:[unit objectForKey:@"end_location"]];
		self.endLocation = end;
		[end release];
		
		self.startAddress = [unit objectForKey:@"start_address"];
		self.endAddress = [unit objectForKey:@"end_address"];
		
	}
	
	return self;
}

-(void)dealloc{
	[self.steps release];
	[self.distance release];
	[self.duration release];
	[self.startAddress release];
	[self.endAddress release];
	[self.startLocation release];
	[self.endLocation release];
	[super dealloc];
}

@end
