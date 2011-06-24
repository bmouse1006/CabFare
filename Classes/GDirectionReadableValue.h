//
//  GDirectionReadableValue.h
//  CabFare
//
//  Created by Jin Jin on 10-10-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GDirectionReadableValue : NSObject {

	NSString* _text;
	NSNumber* _value;
}

@property (nonatomic, retain) NSString* text;
@property (nonatomic, retain) NSNumber* value;

-(id)initWithJSONUnit:(NSDictionary*)unit;

@end
