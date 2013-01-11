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
#import <QuartzCore/CAGradientLayer.h>

@implementation JLFoldableView

- (id)init
{
    self = [super init];
	
	return self;
}

- (UIView *)contentView
{
	return _contentView;
}

- (void)setContentView:(UIView *)contentView
{
	_contentView = [contentView retain];
	[self addSubview:_contentView];
	
	// Eanble perspective transform.
	CATransform3D transform = CATransform3DIdentity;
	transform.m34 = -1 / 500.0;
	[self.layer setSublayerTransform:transform];
	
	_topView = [[UIView alloc] initWithFrame:CGRectMake( 0, -0.25 * _contentView.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.height / 2 )];
	_topView.layer.anchorPoint = CGPointMake( 0.5, 0 );
	[self addSubview:_topView];
	_topView.hidden = YES;
	
	_bottomView = [[UIView alloc] initWithFrame:CGRectMake( 0, 0.75 * _contentView.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.height / 2 )];
	_bottomView.layer.anchorPoint = CGPointMake( 0.5, 1 );
	[self addSubview:_bottomView];
	_bottomView.hidden = YES;
	
	UIImage *image = [_contentView screenshot];
	
	CGImageRef topImage = CGImageCreateWithImageInRect( [image CGImage], CGRectMake( 0, 0, image.size.width * image.scale, image.size.height * image.scale / 2 ) );
	[_topView.layer setContents:(id)topImage];
	CFRelease( topImage );
	
	CGImageRef bottomImage = CGImageCreateWithImageInRect( [image CGImage], CGRectMake( 0, image.size.height*image.scale / 2, image.size.width * image.scale, image.size.height * image.scale / 2 ) );
	[_bottomView.layer setContents:(id)bottomImage];
	CFRelease( bottomImage );
	
	CAGradientLayer *topGradientLayer = [CAGradientLayer layer];
	topGradientLayer.frame = CGRectMake( 0, 0, _contentView.frame.size.width, _contentView.frame.size.height / 2 );
	topGradientLayer.startPoint = CGPointMake( 0, 1 );
	topGradientLayer.endPoint = CGPointMake( 0, 0 );
	topGradientLayer.colors = @[(id)[UIColor colorWithWhite:0 alpha:0.5].CGColor, (id)[UIColor clearColor].CGColor];
	
	_topShadowView = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, _contentView.frame.size.width, _contentView.frame.size.height / 2 )];
	_topShadowView.backgroundColor = [UIColor clearColor];
	[_topShadowView.layer addSublayer:topGradientLayer];
	[_topView addSubview:_topShadowView];
	
	CAGradientLayer *bottomGradientLayer = [CAGradientLayer layer];
	bottomGradientLayer.frame = CGRectMake( 0, -0.5 * _contentView.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.height / 2 );
	bottomGradientLayer.startPoint = CGPointMake( 0, 1 );
	bottomGradientLayer.endPoint = CGPointMake( 0, 0 );
	bottomGradientLayer.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor colorWithWhite:0 alpha:0.7].CGColor];
	
	_bottomShadowView = [[UIView alloc] initWithFrame:CGRectMake( 0, _contentView.frame.size.height / 2, _contentView.frame.size.width, _contentView.frame.size.height / 2 )];
	[_bottomShadowView.layer addSublayer:bottomGradientLayer];
	[_bottomView addSubview:_bottomShadowView];
	
	_fullHeight = _contentView.frame.size.height / 2;
}

- (void)unfoldWithFraction:(CGFloat)fraction
{
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
}

@end
