//
//  GDirectionRoute.h
//  CabFare
//
//  Created by Jin Jin on 10-10-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GDirectionRoute : NSObject {

	NSString* _summary;
	NSArray* _legs;
	NSArray* _waypointsOrder;
	
	//overview path;
	
	NSString* _copyrights;
	NSArray* _warnings;
	
}

@property (nonatomic, retain) NSString* summary;
@property (nonatomic, retain) NSArray* legs;
@property (nonatomic, retain) NSArray* waypointsOrder;
@property (nonatomic, retain) NSString* copyrights;
@property (nonatomic, retain) NSArray* warnings;

-(id)initWithJSONUnit:(NSDictionary*)JSONUnit;

@end
