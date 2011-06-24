//
//  GCalculatorService.h
//  CabFare
//
//  Created by Jin Jin on 10-10-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCalculatorCurrency.h"
#import "GServiceBase.h"

@class GCalculatorService;

@protocol GCalculatorServiceDelegate

-(void)calculatorService:(GCalculatorService*)service didSuccessfullyExchangeCurrency:(GCalculatorCurrency*)from toCurrency:(GCalculatorCurrency*)to;

-(void)calculatorService:(GCalculatorService*)service didFailExchangeCurrencyWithError:(NSError*)error orErrorString:(NSString*)errorString;

@end


@interface GCalculatorService : GServiceBase {
	id<GCalculatorServiceDelegate> delegate;
	

}

@property (nonatomic, assign) id<GCalculatorServiceDelegate> delegate;


-(void)requestToExchangeCurrency:(NSString*)fromCurrency amount:(float)amount toCurrency:(NSString*)toCurrency;
-(NSArray*)parseReceivedString:(NSString*)receivedString;

@end
