//
//  JJPanelView.m
//  CabFare
//
//  Created by Jin Jin on 10-10-23.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "JJPanelView.h"


@implementation JJPanelView

-(id)init{
	if (self = [super init]){

	}
	
	return self;
}

-(void)drawRect:(CGRect)rect{
	self.layer.cornerRadius = 6;
	self.layer.masksToBounds = YES;
	UIColor* bkColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
	self.layer.backgroundColor = bkColor.CGColor;
	self.layer.borderWidth = 0;
	self.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:0.8].CGColor;
	[super drawRect:rect];
}

@end
