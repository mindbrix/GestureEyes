//
//  GestureEyesAnimator.m
//  GestureEyes demo
//
//  Created by Nigel Barber on 20/12/2013.
//  Copyright (c) 2013 Nigel Barber (@mindbrix). All rights reserved.
//

#import "GestureEyesAnimator.h"
#import "UIBezierPath+GestureEyes.h"


@interface GestureEyesAnimator ()

@property( nonatomic, assign ) CGFloat trailSize;

@end


@implementation GestureEyesAnimator

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [ UIColor blackColor ];
        
        self.trailSize = 40.0f;
        
        [ self test ];
        
        UIPanGestureRecognizer *pan = [[ UIPanGestureRecognizer alloc ] initWithTarget:self action:@selector(panGestureRecognizerDidFire:)];
        [ self addGestureRecognizer:pan ];
    }
    return self;
}


-(void)test
{
    NSTimeInterval duration = 1.0f;
    
    NSArray *pinchPaths = [ UIBezierPath pinchPathsForBounds:self.bounds ];
    [ self animateSimultaneouslyWithPaths:pinchPaths duration:duration ];
    
    
    NSArray *rotationPaths = [ UIBezierPath rotationPathsForBounds:self.bounds ];
    [ self animateSimultaneouslyWithPaths:rotationPaths duration:duration ];
    
    
    NSArray *swipePaths = [ UIBezierPath swipePathsForBounds:self.bounds direction:UISwipeGestureRecognizerDirectionUp  numberOfTouchesRequired:1 ];
    [ self animateSimultaneouslyWithPaths:swipePaths duration:duration ];
    
    
    NSArray *edgePathPaths = [ UIBezierPath edgePanPathsForBounds:self.bounds edges:UIRectEdgeBottom | UIRectEdgeTop | UIRectEdgeLeft | UIRectEdgeRight ];
    [ self animateSimultaneouslyWithPaths:edgePathPaths duration:duration];
}



-(void)animateSimultaneouslyWithPaths:(NSArray *)paths duration:(NSTimeInterval)duration
{
    for( UIBezierPath *path in paths )
    {
        GestureEyesPathAnimationLayer *animationLayer = [ GestureEyesPathAnimationLayer layer ];
        [ self.layer addSublayer:animationLayer ];
        
        [ animationLayer animatePaths:@[ path ] withDurations:@[ @( duration )] intervals:@[ @( 1.0 )] animation:^(CGPoint position) {
            
            [ self addTrailAtPosition:position ];
            
        } completion:^{
            [ animationLayer removeFromSuperlayer ];
        }];
    }
}


#pragma mark - Pan gestures

-(void)panGestureRecognizerDidFire:(UIPanGestureRecognizer *)pan
{
    CGPoint location = [ pan locationInView:self ];
    
    [ self addTrailAtPosition:location ];
}


#pragma mark - Trails

-(void)addTrailAtPosition:(CGPoint)position
{
    UIView *trail = [[ UIView alloc ] initWithFrame:CGRectMake( 0.0f, 0.0f, self.trailSize, self.trailSize )];
    trail.layer.cornerRadius = self.trailSize / 2.0f;
    trail.layer.shouldRasterize = YES;
    trail.layer.rasterizationScale = [ UIScreen mainScreen ].scale;
    trail.clipsToBounds = YES;
    trail.backgroundColor = [ UIColor whiteColor ];
    trail.center = position;
    [ self addSubview:trail ];
    
    
    [ UIView animateWithDuration:0.5f animations:^{
        trail.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [ trail removeFromSuperview ];
    }];
}

@end
