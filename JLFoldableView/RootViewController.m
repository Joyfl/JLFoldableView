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
	
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, 320, 200 )];
	contentView.backgroundColor = [self colorWithHex:0xF3EEE9 alpha:1];
	UILabel *topLabel = [[UILabel alloc] initWithFrame:contentView.frame];
	[topLabel setText:@"A"];
	[topLabel setBackgroundColor:[UIColor clearColor]];
	[topLabel setFont:[UIFont boldSystemFontOfSize:200]];
	[topLabel setTextAlignment:NSTextAlignmentCenter];
	[contentView addSubview:topLabel];
	
	_foldableView = [[JLFoldableView alloc] initWithFrame:CGRectMake( 0, 100, 320, 0 )];
	_foldableView.contentView = contentView;
//	[_foldableView setTopGradientColors:@[(id)[UIColor clearColor].CGColor, (id)[UIColor colorWithWhite:0xFFFFFF alpha:1].CGColor, (id)[UIColor colorWithWhite:0 alpha:0.5].CGColor, (id)[UIColor colorWithWhite:0 alpha:1].CGColor]
//							atLocations:@[@0, @0.025, @0.05, @1]];
//	[_foldableView setBottomGradientColors:@[(id)[UIColor colorWithWhite:0 alpha:0.7].CGColor, (id)[UIColor colorWithWhite:0 alpha:0.3].CGColor, (id)[UIColor colorWithWhite:0xFFFFFF alpha:1].CGColor, (id)[UIColor clearColor].CGColor] atLocations:@[@0, @0.95, @0.975, @1]];
	[self.view addSubview:_foldableView];
	
	return self;
}

- (UIColor *)colorWithHex:(NSInteger)color alpha:(CGFloat)alpha
{
	NSInteger red = ( color >> 16 ) & 0xFF;
	NSInteger green = ( color >> 8 ) & 0xFF;
	NSInteger blue = color & 0xFF;
	return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha];
}

- (void)foldCountSliderValueDidChange:(UISlider *)slider
{
	_foldableView.foldCount = slider.value;
}

- (void)fractionSliderValueDidChange:(UISlider *)slider
{
	_foldableView.fraction = slider.value;
}

@end
