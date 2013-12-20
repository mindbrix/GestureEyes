//
//  GestureEyesPathAnimator.h
//  GestureEyes demo
//
//  Created by Nigel Barber on 20/12/2013.
//  Copyright (c) 2013 Nigel Barber (@mindbrix). All rights reserved.
//

@import UIKit;

@class GestureEyesPathAnimationLayer;


@protocol GestureEyesPathAnimationLayerDelegate <NSObject>

@optional
-(void)pathLayerDidAnimate:(GestureEyesPathAnimationLayer *)layer toPosition:(CGPoint)position;

@end



@interface GestureEyesPathAnimationLayer : CALayer

@property( nonatomic, assign ) id<GestureEyesPathAnimationLayerDelegate> animationDelegate;

-(void)animateWithPath:(CGPathRef)path duration:(CFTimeInterval)duration;


@end
