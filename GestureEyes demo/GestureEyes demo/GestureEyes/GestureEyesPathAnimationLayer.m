//
//  GestureEyesPathAnimator.m
//  GestureEyes demo
//
//  Created by Nigel Barber on 20/12/2013.
//  Copyright (c) 2013 Nigel Barber (@mindbrix). All rights reserved.
//

#import "GestureEyesPathAnimationLayer.h"

@interface GestureEyesPathAnimationLayer ()

@property( nonatomic, assign ) NSTimer *pollTimer;

@end



@implementation GestureEyesPathAnimationLayer

-(void)animateWithPath:(CGPathRef)path duration:(CFTimeInterval)duration
{
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.delegate = self;
    pathAnimation.duration = duration;
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.path = path;
    [ self addAnimation:pathAnimation forKey:@"savingAnimation"];
}


-(void)animationDidStart:(CAAnimation *)anim
{
    self.pollTimer = [ NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(pollPosition:) userInfo:nil repeats:YES ];
    [[ NSRunLoop currentRunLoop ] addTimer:self.pollTimer forMode:NSRunLoopCommonModes ];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [ self.pollTimer invalidate ];
}


-(void)pollPosition:(id)sender
{
    if([ self.animationDelegate respondsToSelector:@selector(pathLayerDidAnimate:toPosition:)])
    {
        CALayer *presentationLayer = self.presentationLayer;
        
        [ self.animationDelegate pathLayerDidAnimate:self toPosition:presentationLayer.position ];
    }
}


@end
