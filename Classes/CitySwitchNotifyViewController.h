//
//  CitySwitchNotifyViewController.h
//  CabFare
//
//  Created by Jin Jin on 10-11-22.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CitySwitchNotifyViewController : UIViewController {

	UILabel* _switchLabel;
	UILabel* _cityNameLabel;
	
	NSString* _cityName;
	
}

@property (nonatomic, retain) IBOutlet UILabel* switchLabel;
@property (nonatomic, retain) IBOutlet UILabel* cityNameLabel;
@property (nonatomic, retain, setter=setCityName:) NSString* cityName;

@end
