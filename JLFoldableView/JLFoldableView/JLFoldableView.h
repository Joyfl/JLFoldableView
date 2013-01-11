//
//  JLFoldable.h
//  JLFoldableView
//
//  Created by 전수열 on 13. 1. 11..
//  Copyright (c) 2013년 Joyfl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JLFoldableView : UIView
{
	UIView *_contentView;
	UIView *_topView;
	UIView *_bottomView;
	UIView *_topShadowView;
	UIView *_bottomShadowView;
	CGFloat _fullHeight;
}

@property (nonatomic, retain) UIView *contentView;

- (void)unfoldWithFraction:(CGFloat)fraction;

@end
