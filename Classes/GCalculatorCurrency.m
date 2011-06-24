//
//  GCalculatorCurrency.m
//  CabFare
//
//  Created by Jin Jin on 10-10-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GCalculatorCurrency.h"


@implementation GCalculatorCurrency

@synthesize presentationString = _presentationString;
@synthesize currency = _currency;
@synthesize amount = _amount;

#pragma mark --
#pragma mark Class methods
+(GCalculatorCurrency*)currencyForCurrencyString:(NSString*)currencyString{
	NSRange range = [currencyString rangeOfString:@" "];
	NSString* amountString = [currencyString substringToIndex:range.location];
	NSString* restString = [currencyString substringFromIndex:range.location];
	restString = [restString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	GCalculatorCurrency* gc = [[GCalculatorCurrency alloc] init];
	
	gc.presentationString = currencyString;
	gc.amount = [amountString floatValue];
	gc.currency = restString;
	
	return [gc autorelease];
}

-(void)dealloc{
	[self.presentationString release];
	[self.currency release];
	[super dealloc];
}

@end
