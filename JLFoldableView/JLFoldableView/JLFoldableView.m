//
//  JLFoldable.m
//  JLself
//
//  Created by 전수열 on 13. 1. 11..
//  Copyright (c) 2013년 Joyfl. All rights reserved.
//

#import "JLFoldableView.h"
#import "UIView+Screenshot.h"
#import <QuartzCore/CALayer.h>

@implementation JLFoldableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
	
	// Eanble perspective transform.
	CATransform3D transform = CATransform3DIdentity;
	transform.m34 = -1 / 500.0;
	[self.layer setSublayerTransform:transform];
	
	
	_topView = [[UIView alloc] init];
	[self addSubview:_topView];
	_topView.hidden = YES;
	
	_bottomView = [[UIView alloc] init];
	[self addSubview:_bottomView];
	_bottomView.hidden = YES;
	
	
	_topGradientLayer = [CAGradientLayer layer];
	_topGradientLayer.startPoint = CGPointMake( 0, 1 );
	_topGradientLayer.endPoint = CGPointMake( 0, 0 );
	_topGradientLayer.colors = @[(id)[UIColor colorWithWhite:0 alpha:0.5].CGColor, (id)[UIColor clearColor].CGColor];
	
	_bottomGradientLayer = [CAGradientLayer layer];
	_bottomGradientLayer.startPoint = CGPointMake( 0, 1 );
	_bottomGradientLayer.endPoint = CGPointMake( 0, 0 );
	_bottomGradientLayer.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor colorWithWhite:0 alpha:0.7].CGColor];
	
	
	_topShadowView = [[UIView alloc] init];
	_topShadowView.backgroundColor = [UIColor clearColor];
	[_topShadowView.layer addSublayer:_topGradientLayer];
	[_topView addSubview:_topShadowView];
	
	_bottomShadowView = [[UIView alloc] init];
	[_bottomShadowView.layer addSublayer:_bottomGradientLayer];
	[_bottomView addSubview:_bottomShadowView];
	
	return self;
}

- (id)init
{
	return self = [self initWithFrame:CGRectZero];
}


#pragma mark Getter/Setter

- (UIView *)contentView
{
	return _contentView;
}

- (void)setContentView:(UIView *)contentView
{
	CGFloat originalFraction = _fraction;
	if( originalFraction < 1 )
		self.fraction = 1;
	
	_contentView = [contentView retain];
	[self addSubview:_contentView];
	[_contentView release];
	
	_topView.layer.anchorPoint = CGPointMake( 0.5, 0.5 );
	_topView.frame = CGRectMake( 0, -0.25 * _contentView.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.height / 2 );
	_topView.layer.anchorPoint = CGPointMake( 0.5, 0 );
	
	_bottomView.layer.anchorPoint = CGPointMake( 0.5, 0.5 );
	_bottomView.frame = CGRectMake( 0, 0.75 * _contentView.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.height / 2 );
	_bottomView.layer.anchorPoint = CGPointMake( 0.5, 1 );
	
	UIImage *image = [_contentView screenshot];
	
	CGImageRef topImage = CGImageCreateWithImageInRect( [image CGImage], CGRectMake( 0, 0, image.size.width * image.scale, image.size.height * image.scale / 2 ) );
	[_topView.layer setContents:(id)topImage];
	CFRelease( topImage );
	
	CGImageRef bottomImage = CGImageCreateWithImageInRect( [image CGImage], CGRectMake( 0, image.size.height * image.scale / 2, image.size.width * image.scale, image.size.height * image.scale / 2 ) );
	[_bottomView.layer setContents:(id)bottomImage];
	CFRelease( bottomImage );
	
	_topGradientLayer.frame = CGRectMake( 0, 0, _contentView.frame.size.width, _contentView.frame.size.height / 2 );
	_bottomGradientLayer.frame = CGRectMake( 0, -0.5 * _contentView.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.height / 2 );
	
	_topShadowView.frame = CGRectMake( 0, 0, _contentView.frame.size.width, _contentView.frame.size.height / 2 );
	_bottomShadowView.frame = CGRectMake( 0, _contentView.frame.size.height / 2, _contentView.frame.size.width, _contentView.frame.size.height / 2 );
	
	_fullHeight = _contentView.frame.size.height / 2;
	
	self.fraction = originalFraction;
}

- (void)setFraction:(CGFloat)fraction
{
	if( fraction > 1 ) fraction = 1;
	if( fraction < 0 ) fraction = 0;
	
	_topView.hidden = _bottomView.hidden = fraction == 1;
	_contentView.hidden = !_topView.hidden;
	
	float delta = asinf( fraction );
	float h = _fullHeight * sinf( delta );
	
	CATransform3D transform = CATransform3DMakeTranslation( 0, _fullHeight - h, 0 );
	_topView.layer.transform = CATransform3DRotate( transform, M_PI / 2 - delta, -1, 0, 0 );
	
	transform = CATransform3DMakeTranslation( 0, h - _fullHeight, 0 );
	_bottomView.layer.transform = CATransform3DRotate( transform, M_PI / 2 - delta, 1, 0, 0 );
	
	_topShadowView.alpha = 1 - fraction;
	_bottomShadowView.alpha = 1 - fraction;
	
	_fraction = fraction;
}

@end
