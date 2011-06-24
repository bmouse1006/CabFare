//
//  GDirectionService.m
//  CabFare
//
//  Created by Jin Jin on 10-10-12.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GDirectionService.h"
#import "GDirectionService_private.h"
#import "JSON.h"

#define GDIRECTIONSERVICE_URI @"http://maps.google.com/maps/api/directions/json?"

#define PARAM_ORIGIN			@"origin"
#define PARAM_DESTINATION		@"destination"
#define PARAM_MODE				@"mode"
#define PARAM_WAYPOINTS			@"waypoints"
#define PARAM_ALTERNATIVES		@"alternatives"
#define PARAM_AVOID				@"avoid"
#define PARAM_AVOID_TOLLS		@"tolls"
#define PARAM_AVOID_HIGHWAYS	@"highways"
#define PARAM_LANGUAGE			@"language"
#define PARAM_SENSOR			@"sensor=true"

@implementation GDirectionService

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark NSURLConnection delegate methods
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	DebugLog(@"GDirectionService: did fail with error");
	[self.delegate directionService:self didFailDirectionWithError:error];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
	DebugLog(@"GDirectionService: did received data");
	[self.cacheData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
	DebugLog(@"GDirectionService: did received response");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
	DebugLog(@"GDirectionService: did finish loading");
	NSString* receivedString = [[NSString alloc] initWithData:self.cacheData encoding:NSUTF8StringEncoding];
	NSDictionary* JSONUnit = [receivedString JSONValue];
	[receivedString release];
	
	GDirectionResponse* response = [[GDirectionResponse alloc] initWithDictionary:JSONUnit];
	[self.delegate directionService:self didFinishDirection:response];
	[response release];
}

-(void)requestDirectionFrom:(CLLocation*)from to:(CLLocation*)to waypoints:(NSArray*)waypoints{
	if (!from || !to){
		return;
	}
	
	self.cacheData = [NSMutableData dataWithLength:0];

	NSString* parametersString = [self assemblyParameterStringFrom:from 
																to:to
														 waypoints:waypoints];
	
	NSString* requestString = [GDIRECTIONSERVICE_URI stringByAppendingString:parametersString];
	
	NSURL* url = [NSURL URLWithString:requestString];
	
	NSURLRequest* request = [NSURLRequest requestWithURL:url];
	
	self.connection = [NSURLConnection connectionWithRequest:request 
													delegate:self];
	
}

-(id)init{
	if (self = [super init]){
		self.delegate = nil;
	}
	
	return self;
}

-(void)dealloc{
	[super dealloc];
}

@end

@implementation GDirectionService (private)

-(NSString*)assemblyParameterStringFrom:(CLLocation*)from to:(CLLocation*)to waypoints:(NSArray*)waypoints{
	
	NSMutableString* parameterString = [NSMutableString stringWithCapacity:0];
	
	NSString* param = [PARAM_ORIGIN stringByAppendingFormat:@"=%.6f,%.6f", from.coordinate.latitude, from.coordinate.longitude];
	[parameterString appendFormat:@"%@&", param];
	
	param = [PARAM_DESTINATION stringByAppendingFormat:@"=%.6f,%.6f", to.coordinate.latitude, to.coordinate.longitude];
	[parameterString appendFormat:@"%@&", param];
	
	if ([waypoints count]){
		param = [PARAM_WAYPOINTS stringByAppendingString:@"="];
		[parameterString appendString:param];
		NSString* seperator = @"";
		for (CLLocation* waypoint in waypoints){
			[parameterString appendString:seperator];
			param = [param stringByAppendingFormat:@"%.6f,%.6f", waypoint.coordinate.latitude, waypoint.coordinate.longitude];
			seperator = @"|";
		}
	}
	
	param = [PARAM_LANGUAGE stringByAppendingFormat:@"=%@", @"en"];
	[parameterString appendFormat:@"%@&", param];
	
	[parameterString appendFormat:@"%@", PARAM_SENSOR];
	
	return parameterString;
}

@end

