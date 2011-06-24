//
//  GDirectionRoute.m
//  CabFare
//
//  Created by Jin Jin on 10-10-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GDirectionRoute.h"
#import "GDirectionLeg.h"

@implementation GDirectionRoute

@synthesize summary = _summary;
@synthesize legs = _legs;
@synthesize waypointsOrder = _waypointsOrder;
@synthesize copyrights = _copyrights;
@synthesize warnings = _warnings;

-(id)initWithJSONUnit:(NSDictionary*)unit{
	if (self = [super init]){
		self.summary = [unit objectForKey:@"summary"];
		self.copyrights = [unit objectForKey:@"copyrights"];
		//create legs array
		NSMutableArray* tempLegs = [NSMutableArray arrayWithCapacity:0];
		for (NSDictionary* legUnit in [unit objectForKey:@"legs"]){
			GDirectionLeg* leg = [[GDirectionLeg alloc] initWithJSONUnit:legUnit];
			[tempLegs addObject:leg];
			[leg release];
		}
		
		self.legs = [NSArray arrayWithArray:tempLegs];
		
		self.warnings = [unit objectForKey:@"warnings"];
	}
	
	return self;
}

-(void)dealloc{
	[self.summary release];
	[self.legs release];
	[self.waypointsOrder release];
	[self.copyrights release];
	[self.warnings release];
	[super dealloc];
}

@end
