//
//  GDirectionStep.m
//  CabFare
//
//  Created by Jin Jin on 10-10-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GDirectionStep.h"

@implementation GDirectionStep

@synthesize htmlInstructions = _htmlInstructions;
@synthesize distance = _distance;
@synthesize duration = _duration;
@synthesize startLocation = _startLocation;
@synthesize endLocation = _endLocation;

-(id)initWithJSONUnit:(NSDictionary*)unit{
	if (self = [super init]){
		self.htmlInstructions = [unit objectForKey:@"html_instructions"];
		GDirectionReadableValue* value1 = [[GDirectionReadableValue alloc] initWithJSONUnit:[unit objectForKey:@"distance"]];
		GDirectionReadableValue* value2 = [[GDirectionReadableValue alloc] initWithJSONUnit:[unit objectForKey:@"duration"]];
		self.distance = value1;
		self.duration = value2;
		[value1 release];
		[value2 release];
		
		GDirectionLocation* location1 = [[GDirectionLocation alloc] initWithJSONUnit:[unit objectForKey:@"start_location"]];
		GDirectionLocation* location2 = [[GDirectionLocation alloc] initWithJSONUnit:[unit objectForKey:@"end_location"]];
		self.startLocation = location1;
		self.endLocation = location2;
		[location1 release];
		[location2 release];
	}
	
	return self;
}

-(void)dealloc{
	[self.htmlInstructions release];
	[self.distance release];
	[self.duration release];
	[self.startLocation release];
	[self.endLocation release];
	[super dealloc];
}

@end
