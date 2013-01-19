//
//  JLFoldable.h
//  JLFoldableView
//
//  Created by 전수열 on 13. 1. 11..
//  Copyright (c) 2013년 Joyfl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CAGradientLayer.h>

@interface JLFoldableView : UIView
{
	UIView *_contentView;
	
	UIView *_topView;
	UIView *_bottomView;
	
	CAGradientLayer *_topGradientLayer;
	CAGradientLayer *_bottomGradientLayer;
	
	UIView *_topShadowView;
	UIView *_bottomShadowView;
	
	CGFloat _fullHeight;
}

@property (nonatomic, retain) UIView *contentView;
@property (nonatomic, assign) CGFloat fraction;

//- (void)unfoldWithFraction:(CGFloat)fraction;

@end
