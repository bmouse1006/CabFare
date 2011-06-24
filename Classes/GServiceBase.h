//
//  GServiceBase.h
//  CabFare
//
//  Created by Jin Jin on 10-10-14.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//base class for Google Service
@interface GServiceBase : NSObject {

	NSURLConnection* _connection;
	NSMutableData*	 _cacheData;
	
}

@property (nonatomic, retain) NSURLConnection* connection;
@property (nonatomic, retain) NSMutableData* cacheData;

-(void)cancel;

@end
