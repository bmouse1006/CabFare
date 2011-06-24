//
//  GDirectionService_private.h
//  CabFare
//
//  Created by Jin Jin on 10-10-14.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface GDirectionService (private)

-(NSString*)assemblyParameterStringFrom:(CLLocation*)from to:(CLLocation*)to waypoints:(NSArray*)waypoints;

@end
