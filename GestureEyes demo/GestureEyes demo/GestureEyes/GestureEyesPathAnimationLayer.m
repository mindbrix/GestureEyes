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
    CAKeyframeAnimation *pathAnimation = [ CAKeyframeAnimation animationWithKeyPath:@"position" ];
    pathAnimation.delegate = self;
    pathAnimation.duration = duration;
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.path = path;
    //pathAnimation.repeatCount = HUGE_VALF;
    [ self addAnimation:pathAnimation forKey:@"savingAnimation"];
}


-(void)animationDidStart:(CAAnimation *)anim
{
    self.pollTimer = [ NSTimer scheduledTimerWithTimeInterval:1.0f / 60.0f target:self selector:@selector(pollPosition:) userInfo:nil repeats:YES ];
    [[ NSRunLoop currentRunLoop ] addTimer:self.pollTimer forMode:NSRunLoopCommonModes ];
    
    if([ self.animationDelegate respondsToSelector:@selector(pathLayerAnimationDidStart:)])
    {
        [ self.animationDelegate pathLayerAnimationDidStart:self ];
    }
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [ self.pollTimer invalidate ];
    
    if([ self.animationDelegate respondsToSelector:@selector(pathLayerAnimationDidStop:)])
    {
        [ self.animationDelegate pathLayerAnimationDidStop:self ];
    }
}


-(void)pollPosition:(id)sender
{
    if([ self.animationDelegate respondsToSelector:@selector(pathLayerAnimationDidMove:toPosition:)])
    {
        CALayer *presentationLayer = self.presentationLayer;
        
        [ self.animationDelegate pathLayerAnimationDidMove:self toPosition:presentationLayer.position ];
    }
}


@end
