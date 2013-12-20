//
//  GestureEyesPathAnimator.m
//  GestureEyes demo
//
//  Created by Nigel Barber on 20/12/2013.
//  Copyright (c) 2013 Nigel Barber (@mindbrix). All rights reserved.
//

#import "GestureEyesPathAnimationLayer.h"

@interface GestureEyesPathAnimationLayer ()

@property( nonatomic, strong ) NSTimer *pollTimer;

@end



@implementation GestureEyesPathAnimationLayer

-(void)animateWithPath:(CGPathRef)path duration:(CFTimeInterval)duration
{
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.duration = duration;
    pathAnimation.delegate = self;
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.path = path;
    
    [ self addAnimation:pathAnimation forKey:@"animateWithPath"];
}



-(void)animationDidStart:(CAAnimation *)anim
{
    self.pollTimer = [ NSTimer scheduledTimerWithTimeInterval:1.0f / 10.0f target:self selector:@selector(pollPosition:) userInfo:nil repeats:YES ];
    [[ NSRunLoop currentRunLoop ] addTimer:self.pollTimer forMode:NSRunLoopCommonModes ];
}


-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [ self.pollTimer invalidate ];
}


-(void)pollPosition:(id)sender
{
    CALayer *presentationLayer = self.presentationLayer;
    
    NSLog( @"position = %@", NSStringFromCGPoint( presentationLayer.position ) );
}


@end
