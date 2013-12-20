//
//  GestureEyesPathAnimator.m
//  GestureEyes demo
//
//  Created by Nigel Barber on 20/12/2013.
//  Copyright (c) 2013 Nigel Barber (@mindbrix). All rights reserved.
//

#import "GestureEyesPathAnimationLayer.h"

@implementation GestureEyesPathAnimationLayer

-(void)animateWithPath:(CGPathRef)path duration:(NSTimeInterval)duration
{
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.duration = 2.0f;
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    
    
    pathAnimation.path = path;
    self.animationLayer = [ CALayer layer ];
    
    [ self.layer addSublayer:self.animationLayer ];
    [ self.animationLayer addAnimation:pathAnimation forKey:@"savingAnimation"];
    
    NSTimer *pollTimer = [ NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(pollPosition:) userInfo:nil repeats:YES ];
    [[ NSRunLoop currentRunLoop ] addTimer:pollTimer forMode:NSRunLoopCommonModes ];
}


-(void)test
{
    
}


-(void)pollPosition:(id)sender
{
    CALayer *presentationLayer = self.animationLayer.presentationLayer;
    
    NSLog( @"position = %@", NSStringFromCGPoint( presentationLayer.position ) );
}
@end
