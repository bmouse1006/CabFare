//
//  GDirectionLocation.m
//  CabFare
//
//  Created by Jin Jin on 10-10-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GDirectionLocation.h"


@implementation GDirectionLocation

@synthesize latitude = _latitude;
@synthesize longtitude = _longtitude;

-(id)initWithJSONUnit:(NSDictionary*)unit{
	if (self = [super init]){
		self.latitude = [unit objectForKey:@"lat"];
		self.longtitude = [unit objectForKey:@"lng"];
	}
	
	return self;
}

-(void)dealloc{
	[self.latitude release];
	[self.longtitude release];
	[super dealloc];
}

@end
