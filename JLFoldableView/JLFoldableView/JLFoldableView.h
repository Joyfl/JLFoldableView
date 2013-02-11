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
	
	NSMutableArray *_topViews;
	NSMutableArray *_bottomViews;
	
	NSMutableArray *_topGradientLayers;
	NSMutableArray *_bottomGradientLayers;
	
	NSMutableArray *_topShadowViews;
	NSMutableArray *_bottomShadowViews;
	
	CGFloat _fullHeight;
}

@property (nonatomic, retain) UIView *contentView;
@property (nonatomic, assign) NSInteger foldCount;
@property (nonatomic, assign) CGFloat fraction;

@end
