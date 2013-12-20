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
    self.backgroundColor = [ UIColor blackColor ];
    
    CGPoint endPoint = CGPointMake( self.bounds.size.width, self.bounds.size.height );
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPoint viewOrigin = CGPointZero;
    CGPathMoveToPoint(curvedPath, NULL, viewOrigin.x, viewOrigin.y);
    CGPathAddLineToPoint(curvedPath, NULL, endPoint.x, endPoint.y);
    
    GestureEyesPathAnimationLayer *animationLayer = [ GestureEyesPathAnimationLayer layer ];
    animationLayer.animationDelegate = self;
    [ self.layer addSublayer:animationLayer ];
    [ animationLayer animateWithPath:curvedPath duration:0.333f ];
    
    CGPathRelease(curvedPath);
}


-(void)pathLayerDidAnimate:(GestureEyesPathAnimationLayer *)layer toPosition:(CGPoint)position
{
    //NSLog( @"position = %@", NSStringFromCGPoint( position ) );
    
    [ self addTrailAtPosition:position ];
}


-(void)addTrailAtPosition:(CGPoint)position
{
    UIView *trail = [[ UIView alloc ] initWithFrame:CGRectMake( 0, 0, 40, 40 )];
    trail.backgroundColor = [ UIColor whiteColor ];
    
    [ self addSubview:trail ];
    trail.center = position;
    
    [ UIView animateWithDuration:1.0f animations:^{
        trail.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [ trail removeFromSuperview ];
    }];
}

@end
