//
//  GestureEyesAnimator.m
//  GestureEyes demo
//
//  Created by Nigel Barber on 20/12/2013.
//  Copyright (c) 2013 Nigel Barber (@mindbrix). All rights reserved.
//

#import "GestureEyesAnimator.h"



@interface GestureEyesAnimator ()

@property( nonatomic, strong ) CALayer *animationLayer;

@end


@implementation GestureEyesAnimator

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [ self test ];
    }
    return self;
}


-(void)test
{
    CGPoint endPoint = CGPointMake(480.0f - 30.0f, 240.0f);
    //to end animation in last tab use
    //CGPoint endPoint = CGPointMake( 320-40.0f, 480.0f);
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPoint viewOrigin = CGPointZero;
    CGPathMoveToPoint(curvedPath, NULL, viewOrigin.x, viewOrigin.y);
    CGPathAddCurveToPoint(curvedPath, NULL, endPoint.x, viewOrigin.y, endPoint.x, viewOrigin.y, endPoint.x, endPoint.y);
    
    GestureEyesPathAnimationLayer *animationLayer = [ GestureEyesPathAnimationLayer layer ];
    animationLayer.animationDelegate = self;
    [ self.layer addSublayer:animationLayer ];
    [ animationLayer animateWithPath:curvedPath duration:2.0f ];
    
    CGPathRelease(curvedPath);
}


-(void)pathLayerDidAnimate:(GestureEyesPathAnimationLayer *)layer toPosition:(CGPoint)position
{
    NSLog( @"position = %@", NSStringFromCGPoint( position ) );
}


@end
