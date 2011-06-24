//
//  ConfigViewController.h
//  CabFare
//
//  Created by Jin Jin on 10-10-24.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ConfigViewController : UIViewController {
	UISegmentedControl* _mapStyle;
	UILabel* _autoSwitchLabel;
}

@property (nonatomic, retain) IBOutlet UISegmentedControl* mapStyle;
@property (nonatomic, retain) IBOutlet UILabel* autoSwitchLabel;

-(IBAction)switchMapAndConfigView:(id)sender;

-(IBAction)changeMapViewStyle:(id)sender;
-(IBAction)setAutoSwitchCity:(id)sender;

-(void)localizeUI;

@end
