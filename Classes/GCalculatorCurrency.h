//
//  GCalculatorCurrency.h
//  CabFare
//
//  Created by Jin Jin on 10-10-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GCalculatorCurrency : NSObject {
	NSString* _presentationString;
	NSString* _currency;
	float _amount;
}

@property (nonatomic, retain) NSString* presentationString;
@property (nonatomic, retain) NSString* currency;
@property (assign) float amount;

+(GCalculatorCurrency*)currencyForCurrencyString:(NSString*)currencyString;

@end
