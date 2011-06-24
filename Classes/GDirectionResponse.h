//
//  GDirectionResponse.h
//  CabFare
//
//  Created by Jin Jin on 10-10-12.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDirectionRoute.h"
#import "GDirectionLocation.h"

//define status message
/***
* OK 表示响应包含一个有效的 result。
* NOT_FOUND 表示至少有一个在请求的起点、目的地或路标中指定的位置无法进行地址解析。
* ZERO_RESULTS 表示无法在起点和终点之间找到路线。
* MAX_WAYPOINTS_EXCEEDED 表示请求中包含过多的 waypoints。允许的最大 waypoints 数为 8，再加上起点和目的地。（Google Maps Premier 客户可以在请求中提及多达 23 个路标。）
* INVALID_REQUEST 表示提供的请求无效。
* OVER_QUERY_LIMIT 表示该服务在允许的时间段内从您的应用程序收到了过多的请求。
* REQUEST_DENIED 表示该服务已拒绝您的应用程序使用路线服务。
* UNKNOWN_ERROR 表示路线请求因服务器出错而无法得到处理。如果您再试一次，该请求可能会成功。
***/

#define STATUS_OK @"OK"
#define STATUS_NOT_FOUND @"NOT_FOUND"
#define STATUS_ZERO_RESULTS @"ZERO_RESULTS"
#define STATUS_MAX_WAYPOINTS_EXCEEDED @"MAX_WAYPOINTS_EXCEEDED"
#define STATUS_INVALID_REQUEST @"INVALID_REQUEST"
#define STATUS_OVER_QUERY_LIMIT @"OVER_QUERY_LIMIT"
#define STATUS_REQUEST_DENIED @"REQUEST_DENIED"
#define STATUS_UNKNOWN_ERROR @"UNKNOWN_ERROR"

@interface GDirectionResponse : NSObject {

	NSString* _status;
	
	NSArray* _routes;
	
}

@property (nonatomic, retain) NSArray* routes;
@property (nonatomic, retain) NSString* status;

-(id)initWithJSONUnit:(NSDictionary*)unit;

@end
