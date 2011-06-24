//
//  TestWindow.m
//  CabFare
//
//  Created by Jin Jin on 10-10-9.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TestWindow.h"
#import "CabFareCalculator.h"

@implementation TestWindow

@synthesize cityName = _cityName;
@synthesize distance = _distance;
@synthesize result = _result;
@synthesize calculator = _calculator;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

#pragma mark -
#pragma mark view life cycle
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark -
#pragma mark memory management
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark -
#pragma mark delegate methods
-(void)didSuccessfullyExchangeCurrency:(GCalculatorCurrency*)from toCurrency:(GCalculatorCurrency*)to{
	DebugLog(@"from currency");
	DebugLog(@"currency is%@", from.currency);
	DebugLog(@"amount is %f", from.amount);
	
	DebugLog(@"to currency");
	DebugLog(@"currency is%@", to.currency);
	DebugLog(@"amount is %f", to.amount);
}

-(void)failedExchangeCurrencyWithError:(NSError*)error orErrorString:(NSString*)errorString{

}

#pragma mark -
#pragma mark IBActions
-(IBAction)calculate:(id)sender{
	CabFareCalculator* calculator = [[CabFareCalculator alloc] init];
	NSNumber* mileage = [NSNumber numberWithFloat:[self.distance.text floatValue]];
	NSNumber* fare = [calculator cabFare:self.cityName.text mileage:mileage time:nil];
	self.result.text = [fare stringValue];
	//cacluate
}

-(IBAction)exchangeTest:(id)sender{
	DebugLog(@"TestWindow: exchangeTest");
	GCalculatorService* temp = [[GCalculatorService alloc] init];
	temp.delegate = self;
	self.calculator = temp;
	[temp release];
	
	[self.calculator requestToExchangeCurrency:@"USD" amount:1 toCurrency:@"CNY"];
	
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[self.distance release];
	[self.cityName release];
	[self.result release];
	[self.calculator release];
    [super dealloc];
}


@end
