//
//  GDirectionService.h
//  CabFare
//
//  Created by Jin Jin on 10-10-12.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "GDirectionResponse.h"
#import "GServiceBase.h"

@class GDirectionService;

@protocol GDirectionServiceDelegate

-(void)directionService:(GDirectionService*)service didFinishDirection:(GDirectionResponse*)response;

-(void)directionService:(GDirectionService*)service didFailDirectionWithError:(NSError*)error;

@end

@interface GDirectionService : GServiceBase {

	id<GDirectionServiceDelegate> _delegate;
	
}

@property (nonatomic, assign) id<GDirectionServiceDelegate> delegate;

-(void)requestDirectionFrom:(CLLocation*)from to:(CLLocation*)to waypoints:(NSArray*)waypoints;

@end
