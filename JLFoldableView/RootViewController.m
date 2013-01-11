//
//  RootViewController.m
//  FoldViewTest
//
//  Created by 전수열 on 13. 1. 11..
//  Copyright (c) 2013년 Joyfl. All rights reserved.
//

#import "RootViewController.h"
#import "UIView+Screenshot.h"
#import <QuartzCore/CALayer.h>
#import <QuartzCore/CAGradientLayer.h>

@implementation RootViewController

- (id)init
{
	self = [super init];
	self.view.backgroundColor = [UIColor lightGrayColor];
	
	UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake( 10, 10, 300, 20 )];
	slider.maximumValue = 1;
	slider.value = 1;
	[slider addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
	[self.view addSubview:slider];
	
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, 320, 300 )];
	[contentView setBackgroundColor:[UIColor whiteColor]];
	UILabel *topLabel = [[UILabel alloc] initWithFrame:contentView.frame];
	[topLabel setText:@"A"];
	[topLabel setBackgroundColor:[UIColor clearColor]];
	[topLabel setFont:[UIFont boldSystemFontOfSize:300]];
	[topLabel setTextAlignment:NSTextAlignmentCenter];
	[contentView addSubview:topLabel];
	[contentView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
	
	_foldableView = [[JLFoldableView alloc] initWithFrame:CGRectMake( 0, 50, 320, 300 )];
	_foldableView.contentView = contentView;
	[self.view addSubview:_foldableView];
	
	return self;
}

- (void)sliderValueDidChange:(UISlider *)slider
{
	[_foldableView unfoldWithFraction:slider.value];
}

@end
