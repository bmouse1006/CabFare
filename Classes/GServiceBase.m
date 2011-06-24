//
//  GServiceBase.m
//  CabFare
//
//  Created by Jin Jin on 10-10-14.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GServiceBase.h"


@implementation GServiceBase

@synthesize connection = _connection;
@synthesize cacheData = _cacheData;

-(void)cancel{
	[self.connection cancel];
	self.connection = nil;
}

-(void)dealloc{
	[self.connection release];
	[self.cacheData release];
	[super dealloc];
}

@end
