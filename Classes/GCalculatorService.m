//
//  GCalculatorService.m
//  CabFare
//
//  Created by Jin Jin on 10-10-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GCalculatorService.h"

//#define SERVICE_URI_FORMAT @"www.google.com/ig/calculator?hl=en&q=%@%@=?%@"
#define SERVICE_URI_FORMAT @"http://www.google.com/ig/calculator?hl=en&q=%.2f%@=?%@"
#define RETURNKEY_FROMCURRENCY	@"lhs"
#define RETURNKEY_TOCURRENCY	@"rhs"
#define RETURNKEY_ERROR			@"error"
#define RETURNKEY_ICC			@"icc"

@implementation GCalculatorService

@synthesize delegate;

#pragma mark -
#pragma mark NSURLConnection delegate methods
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	[self.delegate calculatorService:self didFailExchangeCurrencyWithError:error orErrorString:nil];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
	DebugLog(@"GCalculatorService: did received data");
	[self.cacheData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
	DebugLog(@"GCalculatorService: did received response");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
	DebugLog(@"GCalculatorService: did finish loading");
	NSString* receivedString = [[NSString alloc] initWithData:self.cacheData 
													 encoding:NSUTF8StringEncoding];
	DebugLog(@"GCalculatorService: received string is %@", receivedString);
	
	NSArray* parsedResults = [self parseReceivedString:receivedString];
	
	NSString* fromCurrencyString = [parsedResults objectAtIndex:1];
	NSString* toCurrencyString = [parsedResults objectAtIndex:3];
	NSString* errorString = [parsedResults objectAtIndex:5];
	
	if (!errorString || [errorString isEqualToString:@""]){//no error happened
		GCalculatorCurrency* from = [GCalculatorCurrency currencyForCurrencyString:fromCurrencyString];
		GCalculatorCurrency* to = [GCalculatorCurrency currencyForCurrencyString:toCurrencyString];
		[self.delegate calculatorService:self didSuccessfullyExchangeCurrency:from toCurrency:to];
	}
	
	//error happened
	[self.delegate calculatorService:self didFailExchangeCurrencyWithError:nil orErrorString:errorString];
}

-(NSArray*)parseReceivedString:(NSString*)receivedString{
	return [receivedString componentsSeparatedByString:@"\""];
}


//entry to calculate currency
-(void)requestToExchangeCurrency:(NSString*)fromCurrency 
						  amount:(float)amount 
					  toCurrency:(NSString*)toCurrency{
	if (!fromCurrency || !toCurrency){
		return;
	}
	DebugLog(@"GCalculatorService: request to exchange currency");
	[self cancel];
	
	self.cacheData = [NSMutableData dataWithLength:0];
	
	NSString* serviceURLString = [NSString stringWithFormat:SERVICE_URI_FORMAT, amount, fromCurrency, toCurrency];
	
	DebugLog(@"request URL is %@", serviceURLString);
	
	NSURL* url = [NSURL URLWithString:serviceURLString];
	
	NSURLRequest* request = [NSURLRequest requestWithURL:url];
	
	self.connection = [NSURLConnection connectionWithRequest:request 
													delegate:self];
	
}
		 
-(id)init{
	if (self = [super init]){
		self.delegate = nil;
	}
	return self;
}

-(void)dealloc{
	[super dealloc];
}

@end
