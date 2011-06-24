//
//  GDirectionStep.h
//  CabFare
//
//  Created by Jin Jin on 10-10-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDirectionReadableValue.h"
#import "GDirectionLocation.h"

@interface GDirectionStep : NSObject {
	NSString* _htmlInstructions;
	GDirectionReadableValue* _distance;
	GDirectionReadableValue* _duration;
	GDirectionLocation* _startLocation;
	GDirectionLocation* _endLocation;
}

@property (nonatomic, retain) NSString* htmlInstructions;
@property (nonatomic, retain) GDirectionReadableValue* distance;
@property (nonatomic, retain) GDirectionReadableValue* duration;
@property (nonatomic, retain) GDirectionLocation* startLocation;
@property (nonatomic, retain) GDirectionLocation* endLocation;

-(id)initWithJSONUnit:(NSDictionary*)unit;

@end
