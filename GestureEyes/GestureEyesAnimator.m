//
//  GestureEyesAnimator.m
//  GestureEyes demo
//
//  Created by Nigel Barber on 20/12/2013.
//  Copyright (c) 2013 Nigel Barber (@mindbrix). All rights reserved.
//

#import "GestureEyesAnimator.h"

#import "GestureEyesPathAnimationLayer.h"


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
    
    [ self.layer addSublayer:animationLayer ];
    
    [ animationLayer animateWithPath:curvedPath duration:2.0f ];
    
    
    CGPathRelease(curvedPath);
    
    
    
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.duration = 2.0f;
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    //Setting Endpoint of the animation
    pathAnimation.path = curvedPath;
    
    self.animationLayer = [ CALayer layer ];
    
    [ self.layer addSublayer:self.animationLayer ];
    [ self.animationLayer addAnimation:pathAnimation forKey:@"savingAnimation"];
    
    NSTimer *pollTimer = [ NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(pollPosition:) userInfo:nil repeats:YES ];
    [[ NSRunLoop currentRunLoop ] addTimer:pollTimer forMode:NSRunLoopCommonModes ];
}


-(void)pollPosition:(id)sender
{
    CALayer *presentationLayer = self.animationLayer.presentationLayer;
    
    NSLog( @"position = %@", NSStringFromCGPoint( presentationLayer.position ) );
}

@end
