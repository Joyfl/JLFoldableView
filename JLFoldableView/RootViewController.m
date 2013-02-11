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
	
	UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake( 10, 10, 300, 40 )];
	slider.maximumValue = 1;
	slider.value = 1;
	[slider addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
	[self.view addSubview:slider];
	
	UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, 320, 200 )];
	[contentView setBackgroundColor:[UIColor whiteColor]];
	UILabel *topLabel = [[UILabel alloc] initWithFrame:contentView.frame];
	[topLabel setText:@"A"];
	[topLabel setBackgroundColor:[UIColor clearColor]];
	[topLabel setFont:[UIFont boldSystemFontOfSize:200]];
	[topLabel setTextAlignment:NSTextAlignmentCenter];
	[contentView addSubview:topLabel];
	
	_foldableView = [[JLFoldableView alloc] initWithFrame:CGRectMake( 0, 50, 320, 0 )];
	_foldableView.contentView = contentView;
	[self.view addSubview:_foldableView];
	
	label2 = [[UILabel alloc] initWithFrame:CGRectMake( 0, 0, 320, 120 )];
	[label2 setText:@"B"];
	[label2 setFont:[UIFont boldSystemFontOfSize:120]];
	[label2 setTextAlignment:NSTextAlignmentCenter];
	
//	_foldableView2 = [[JLFoldableView alloc] initWithFrame:CGRectMake( 0, 250, 320, 0 )];
//	_foldableView2.contentView = label2;
//	_foldableView2.fraction = 1;
//	[self.view addSubview:_foldableView2];
	
	return self;
}

- (void)sliderValueDidChange:(UISlider *)slider
{
	_foldableView.fraction = slider.value;
	
	_foldableView2.contentView = label2;
	_foldableView2.fraction = slider.value;
}

@end
