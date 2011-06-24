//
//  UserPreferenceDefine.m
//
//  Created by Jin Jin on 10-7-20.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UserPreferenceDefine.h"

#define PREFERENCEBUNDLENAME_PHONE	@"ConfigBundle_phone"
#define PREFERENCEBUNDLENAME_PAD	@"ConfigBundle_pad"

//#define KEY_AUTOROTATION	@"AutoRotation"
//#define KEY_ENABLESSL		@"EnableSSL"
//#define KEY_AUTOHIDESUBWITHNOITEM	@"AutoHideForNoItem"
//#define KEY_ARTICLEPREVIEW	@"ArticlePreview"
//#define KEY_MARKDOWNLOADEDASREAD	@"MarkDownloadedAsRead"
//#define KEY_SHOWUNREADFIRST @"ShowUnreadFirst"

#define KEY_DEFAULTCITY @"defaultCity"

@implementation UserPreferenceDefine

static NSDictionary* preferenceBundle = nil;

+(NSString*)defaultCity{
	return [self stringValueForKey:KEY_DEFAULTCITY];
}

+(void)setDefaultCity:(NSString*)city{
	[self valueChangedForKey:KEY_DEFAULTCITY value:city];
}

+(void)valueChangedForKey:(NSString*)key value:(id)value{
	[[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
}

+(void)resetPreference{
	DebugLog(@"use defaults are reseted");
	NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults removeObjectForKey:KEY_DEFAULTCITY];
}

//+(BOOL)shouldShowUnreadFirst{
//	NSString* key = KEY_SHOWUNREADFIRST;
//	return [self boolValueForKey:key];
//}
		
+(BOOL)boolValueForKey:(NSString*)key{
	NSNumber* value = (NSNumber*)[[NSUserDefaults standardUserDefaults] objectForKey:key];
	if (!value){
		value = [self preferenceObjectForKey:key];
	}
	
	return [value boolValue];
}

+(NSString*)stringValueForKey:(NSString*)key{
	NSString* value = (NSString*)[[NSUserDefaults standardUserDefaults] objectForKey:key];
	if (!value){
		value = [self preferenceObjectForKey:key];
	}
	
	return value;
}

+(NSDictionary*)userPreferenceBundle{
	if (!preferenceBundle){
		
		NSString* bundleName = PREFERENCEBUNDLENAME_PHONE;
		
		if ([self iPadMode]){
			bundleName = PREFERENCEBUNDLENAME_PAD;
		}
		
		NSString *filePath = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"plist"];
		
		preferenceBundle = [[NSDictionary alloc] initWithContentsOfFile:filePath];
	}
	
	return preferenceBundle;
}

+(id)preferenceObjectForKey:(NSString*)key{
	NSDictionary* preference = [self userPreferenceBundle];
	
	NSEnumerator* enumerator = [preference objectEnumerator];
	
	NSDictionary* section = nil;
	
	NSArray* attributes = nil;
	
	while (section = [enumerator nextObject]) {
		attributes = [section objectForKey:key];
		if (attributes){
			break;
		}
	}
	
	
	if ([attributes count] < 2){
		return nil;
	}
	
	return [attributes objectAtIndex:0];
}

+(BOOL)iPadMode{
	
	BOOL iPad = NO;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {      
		iPad = YES;
	}
	
	return iPad;
}

@end
