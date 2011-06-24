//
//  GDirectionLocation.h
//  CabFare
//
//  Created by Jin Jin on 10-10-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GDirectionLocation : NSObject {
	NSNumber* _latitude;
	NSNumber* _longtitude;

}

@property (nonatomic, retain) NSNumber* latitude;
@property (nonatomic, retain) NSNumber* longtitude;

@end
