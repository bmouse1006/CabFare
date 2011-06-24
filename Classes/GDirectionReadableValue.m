//
//  GDirectionReadableValue.m
//  CabFare
//
//  Created by Jin Jin on 10-10-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GDirectionReadableValue.h"


@implementation GDirectionReadableValue

@synthesize text = _text;
@synthesize value = _value;

-(id)initWithJSONUnit:(NSDictionary*)unit{
	if (self = [super init]){
		self.text = [unit objectForKey:@"text"];
		self.value = [unit objectForKey:@"value"];
	}
	
	return self;
}

-(void)dealloc{
	[self.text release];
	[self.value release];
	[super dealloc];
}

@end
