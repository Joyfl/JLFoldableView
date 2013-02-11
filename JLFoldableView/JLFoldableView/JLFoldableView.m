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
	
	_foldCount = 3;
	
	_topViews = [[NSMutableArray alloc] init];
	_bottomViews = [[NSMutableArray alloc] init];
	
	_topGradientLayers = [[NSMutableArray alloc] init];
	_bottomGradientLayers = [[NSMutableArray alloc] init];
	
	_topShadowViews = [[NSMutableArray alloc] init];
	_bottomShadowViews = [[NSMutableArray alloc] init];
	
	for( NSInteger i = 0; i < _foldCount; i++ )
	{
		UIView *topView = [[UIView alloc] init];
		[self addSubview:topView];
//		topView.hidden = YES;
		[_topViews addObject:topView];
		
		UIView *bottomView = [[UIView alloc] init];
		[self addSubview:bottomView];
//		bottomView.hidden = YES;
		[_bottomViews addObject:bottomView];
		
		CAGradientLayer *topGradientLayer = [CAGradientLayer layer];
		topGradientLayer.startPoint = CGPointMake( 0, 1 );
		topGradientLayer.endPoint = CGPointMake( 0, 0 );
		topGradientLayer.colors = @[(id)[UIColor colorWithWhite:0 alpha:0.5].CGColor, (id)[UIColor clearColor].CGColor];
		[_topGradientLayers addObject:topGradientLayer];
		
		CAGradientLayer *bottomGradientLayer = [CAGradientLayer layer];
		bottomGradientLayer.startPoint = CGPointMake( 0, 1 );
		bottomGradientLayer.endPoint = CGPointMake( 0, 0 );
		bottomGradientLayer.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor colorWithWhite:0 alpha:0.7].CGColor];
		[_bottomGradientLayers addObject:bottomGradientLayer];
		
		UIView *topShadowView = [[UIView alloc] init];
		topShadowView.backgroundColor = [UIColor clearColor];
		[topShadowView.layer addSublayer:topGradientLayer];
		[topView addSubview:topShadowView];
		[_topShadowViews addObject:topShadowView];
		
		UIView *bottomShadowView = [[UIView alloc] init];
		[bottomShadowView.layer addSublayer:bottomGradientLayer];
		[bottomView addSubview:bottomShadowView];
		[_bottomShadowViews addObject:bottomShadowView];
	}
	
	_fraction = 1;
	
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
	
	UIImage *image = [_contentView screenshot];
	for( NSInteger i = 0; i < _foldCount; i++ )
	{
		UIView *topView = [_topViews objectAtIndex:i];
		topView.layer.anchorPoint = CGPointMake( 0.5, 0 );
		topView.frame = CGRectMake( 0, _contentView.frame.size.height * ( i * 2 ) / ( 2 * _foldCount ), _contentView.frame.size.width, _contentView.frame.size.height / ( 2 * _foldCount ) );
		
		UIView *bottomView = [_bottomViews objectAtIndex:i];
		bottomView.layer.anchorPoint = CGPointMake( 0.5, 1 );
		bottomView.frame = CGRectMake( 0, _contentView.frame.size.height * ( i * 2 + 1 ) / ( 2 * _foldCount ), _contentView.frame.size.width, _contentView.frame.size.height / ( 2 * _foldCount ) );
		
		NSLog( @"topView[%d].y : %f", i, topView.frame.origin.y );
		NSLog( @"bottomView[%d].y : %f", i, bottomView.frame.origin.y );
		
		CGFloat imageHeight = image.size.height * image.scale / ( 2 * _foldCount );
		CGImageRef topImage = CGImageCreateWithImageInRect( [image CGImage], CGRectMake( 0, imageHeight * i * 2, image.size.width * image.scale, imageHeight ) );
		[topView.layer setContents:(id)topImage];
		CFRelease( topImage );
		
		CGImageRef bottomImage = CGImageCreateWithImageInRect( [image CGImage], CGRectMake( 0, imageHeight * ( i * 2 + 1 ), image.size.width * image.scale, imageHeight ) );
		[bottomView.layer setContents:(id)bottomImage];
		CFRelease( bottomImage );
		
		CAGradientLayer *topGradientLayer = [_topGradientLayers objectAtIndex:i];
		CAGradientLayer *bottomGradientLayer = [_bottomGradientLayers objectAtIndex:i];
		
		topGradientLayer.frame = CGRectMake( 0, 0, _contentView.frame.size.width, _contentView.frame.size.height / ( 2 * _foldCount ) );
		bottomGradientLayer.frame = CGRectMake( 0, _contentView.frame.size.height / ( -2 * _foldCount ), _contentView.frame.size.width, _contentView.frame.size.height / ( 2 * _foldCount ) );
		
		UIView *topShadowView = [_topShadowViews objectAtIndex:i];
		UIView *bottomShadowView = [_bottomShadowViews objectAtIndex:i];
		
		topShadowView.frame = CGRectMake( 0, 0, _contentView.frame.size.width, _contentView.frame.size.height / ( 2 * _foldCount ) );
		bottomShadowView.frame = CGRectMake( 0, _contentView.frame.size.height / ( 2 * _foldCount ), _contentView.frame.size.width, _contentView.frame.size.height / ( 2 * _foldCount ) );
	}
	
	_fullHeight = _contentView.frame.size.height / ( _foldCount + 1 );
	_contentView.hidden = YES;
	
	self.fraction = originalFraction;
}

- (void)setFoldCount:(NSInteger)foldCount
{
	
}

- (void)setFraction:(CGFloat)fraction
{
	if( fraction > 1 ) fraction = 1;
	if( fraction < 0 ) fraction = 0;
	
	float theta = asinf( fraction );
	
	for( NSInteger i = 0; i < _foldCount; i++ )
	{
		UIView *topView = [_topViews objectAtIndex:i];
		UIView *bottomView = [_bottomViews objectAtIndex:i];
		
		topView.hidden = bottomView.hidden = fraction == 1;
		_contentView.hidden = !topView.hidden;
		
		CGFloat topY = -i * _contentView.frame.size.height * ( 1 - sinf( theta ) ) / _foldCount;
	
		CATransform3D transform = CATransform3DMakeTranslation( 0, topY, 0 );
		topView.layer.transform = CATransform3DRotate( transform, M_PI / 2 - theta, -1, 0, 0 );
		
		CGFloat bottomY = -1 * ( i + 1 ) * _contentView.frame.size.height * ( 1 - sinf( theta ) ) / _foldCount;
		
		transform = CATransform3DMakeTranslation( 0, bottomY, 0 );
		bottomView.layer.transform = CATransform3DRotate( transform, M_PI / 2 - theta, 1, 0, 0 );
		
		UIView *topShadowView = [_topShadowViews objectAtIndex:i];
		UIView *bottomShadowView = [_bottomShadowViews objectAtIndex:i];
		
		topShadowView.alpha = 1 - fraction;
		bottomShadowView.alpha = 1 - fraction;
	}
	
	_fraction = fraction;
}

@end
