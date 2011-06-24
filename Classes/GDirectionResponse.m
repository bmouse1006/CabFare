//
//  GDirectionResponse.m
//  CabFare
//
//  Created by Jin Jin on 10-10-12.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GDirectionResponse.h"
#import "GDirectionRoute.h"

@implementation GDirectionResponse

@synthesize routes = _routes;
@synthesize status = _status;

-(id)initWithJSONUnit:(NSDictionary*)unit{
	if (self = [super init]){
		self.status = [unit objectForKey:@"status"];
		NSMutableArray* tempRoutes = [NSMutableArray arrayWithCapacity:0];
		//create route array
		for (NSDictionary* routeUnit in [unit objectForKey:@"routes"]){
			GDirectionRoute* route = [[GDirectionRoute alloc] initWithJSONUnit:routeUnit];
			[tempRoutes addObject:route];
			[route release];
		}
		self.routes = [NSArray arrayWithArray:tempRoutes];
	}
	
	return self;
}

-(void)dealloc{
	[self.routes release];
	[self.status release];
	[super dealloc];
}

@end
