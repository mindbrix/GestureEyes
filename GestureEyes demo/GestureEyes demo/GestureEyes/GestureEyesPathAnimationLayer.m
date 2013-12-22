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

@property( nonatomic, assign ) NSInteger index;

@property( nonatomic, strong ) NSArray *paths;
@property( nonatomic, strong ) NSArray *durations;
@property( nonatomic, strong ) NSArray *intervals;

@end



@implementation GestureEyesPathAnimationLayer


-(void)animatePaths:(NSArray *)paths withDurations:(NSArray *)durations intervals:(NSArray *)intervals animation:(void (^)( CGPoint position ))animationBlock completion:(void (^)(void))completionsBlock
{
    self.index = 0;
    self.paths = paths;
    self.durations = durations;
    self.intervals = intervals;
    
    self.animationBlock = animationBlock;
    self.completionsBlock = completionsBlock;
    
    [ self nextAnimation ];
}


-(void)nextAnimation
{
    if( self.index < self.paths.count )
    {
        UIBezierPath *path = [ self.paths objectAtIndex:self.index ];
        
        CFTimeInterval duration = [[ self.durations objectAtIndex:self.index % self.durations.count ] doubleValue ];
        
        [ self animateWithPath:path.CGPath duration:duration ];
    }
}


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
    dispatch_async( dispatch_get_main_queue(), ^{
        self.pollTimer = [ NSTimer scheduledTimerWithTimeInterval:1.0f / 60.0f target:self selector:@selector(pollPosition:) userInfo:nil repeats:YES ];
        [[ NSRunLoop currentRunLoop ] addTimer:self.pollTimer forMode:NSRunLoopCommonModes ];
    });
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [ self.pollTimer invalidate ];
    
    self.index++;
    
    if( self.index < self.paths.count )
    {
        NSTimeInterval interval = [[ self.intervals objectAtIndex:self.index % self.intervals.count ] doubleValue ];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, interval * 1000.0 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
            
            [ self nextAnimation ];
        });
    }
    else
    {
        if( self.completionsBlock )
        {
            self.completionsBlock();
        }
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
