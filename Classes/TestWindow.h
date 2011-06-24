//
//  TestWindow.h
//  CabFare
//
//  Created by Jin Jin on 10-10-9.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCalculatorService.h"

@interface TestWindow : UIViewController<GCalculatorServiceDelegate> {

	GCalculatorService* _calculator;
	
	UITextField* _cityName;
	UITextField* _distance;
	
	UILabel* _result;
}

@property (nonatomic, retain) IBOutlet UITextField* cityName;
@property (nonatomic, retain) IBOutlet UITextField* distance;
@property (nonatomic, retain) IBOutlet UILabel* result;

@property (nonatomic, retain) GCalculatorService* calculator;

-(IBAction)calculate:(id)sender;
-(IBAction)exchangeTest:(id)sender;

@end
