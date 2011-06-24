//
//  UserPreferenceDefine.h
//
//  Created by Jin Jin on 10-7-20.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserPreferenceDefine : NSObject
{
	
}

+(void)valueChangedForKey:(NSString*)key value:(id)value;

+(void)resetPreference;

+(NSString*)defaultCity;
+(void)setDefaultCity:(NSString*)city;

+(NSDictionary*)userPreferenceBundle;

+(id)preferenceObjectForKey:(NSString*)key;

+(BOOL)boolValueForKey:(NSString*)key;
+(NSString*)stringValueForKey:(NSString*)key;

+(BOOL)iPadMode;

@end