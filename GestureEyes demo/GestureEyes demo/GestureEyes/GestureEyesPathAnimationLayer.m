//
//  GestureEyesPathAnimator.m
//  GestureEyes demo
//
//  Created by Nigel Barber on 20/12/2013.
//  Copyright (c) 2013 Nigel Barber (@mindbrix). All rights reserved.
//

#import "GestureEyesPathAnimationLayer.h"

@interface GestureEyesPathAnimationLayer ()

@property (nonatomic, copy) void (^animationBlock)(CGPoint position);
@property (nonatomic, copy) void (^completionsBlock)(void);
@property( nonatomic, assign ) NSTimer *pollTimer;

@end



@implementation GestureEyesPathAnimationLayer

-(void)animateWithPath:(CGPathRef)path duration:(CFTimeInterval)duration animation:(void (^)( CGPoint position ))animationBlock completion:(void (^)(void))completionsBlock
{
    self.animationBlock = animationBlock;
    self.completionsBlock = completionsBlock;
    
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
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [ self.pollTimer invalidate ];
    
    if( self.completionsBlock )
    {
        self.completionsBlock();
    }
}


-(void)pollPosition:(id)sender
{
    if( self.animationBlock )
    {
        CALayer *presentationLayer = self.presentationLayer;
        
        self.animationBlock( presentationLayer.position );
    }
}


@end
