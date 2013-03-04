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
	
	UISlider *foldCountSlider = [[UISlider alloc] initWithFrame:CGRectMake( 10, 10, 300, 40 )];
	foldCountSlider.maximumValue = 10;
	foldCountSlider.minimumValue = 1;
	foldCountSlider.continuous = NO;
	foldCountSlider.value = 1;
	[foldCountSlider addTarget:self action:@selector(foldCountSliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
	[self.view addSubview:foldCountSlider];
	
	UISlider *fractionSlider = [[UISlider alloc] initWithFrame:CGRectMake( 10, 50, 300, 40 )];
	fractionSlider.value = 1;
	[fractionSlider addTarget:self action:@selector(fractionSliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
	[self.view addSubview:fractionSlider];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	button.frame = CGRectMake( 10, 350, 300, 40 );
	[button addTarget:self action:@selector(buttonDidTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button];
	
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, 320, 200 )];
	contentView.backgroundColor = [UIColor whiteColor];
	UILabel *topLabel = [[UILabel alloc] initWithFrame:contentView.frame];
	[topLabel setText:@"A"];
	[topLabel setBackgroundColor:[UIColor clearColor]];
	[topLabel setFont:[UIFont boldSystemFontOfSize:200]];
	[topLabel setTextAlignment:NSTextAlignmentCenter];
	[contentView addSubview:topLabel];
	
	_foldableView = [[JLFoldableView alloc] initWithFrame:CGRectMake( 0, 100, 320, 0 )];
	_foldableView.contentView = contentView;
	[self.view addSubview:_foldableView];
	
	return self;
}

- (void)foldCountSliderValueDidChange:(UISlider *)slider
{
	_foldableView.foldCount = slider.value;
}

- (void)fractionSliderValueDidChange:(UISlider *)slider
{
	_foldableView.fraction = slider.value;
}

- (void)buttonDidTouchUpInside
{
	_foldableView.fraction = 0;
	[_foldableView setFraction:1 animated:YES completion:^(BOOL complete) {
		NSLog( @"wow" );
	}];
}

@end
