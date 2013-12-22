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

@property( nonatomic, strong ) GestureEyesPathAnimationLayer *animationLayer;
@property( nonatomic, assign ) NSInteger animationPathIndex;
@property( nonatomic, assign ) CGFloat trailSize;
@end


@implementation GestureEyesAnimator

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.trailSize = 40.0f;
        
        self.animationLayer = [ GestureEyesPathAnimationLayer layer ];
        [ self.layer addSublayer:self.animationLayer ];
        
        [ self test ];
        
        UIPanGestureRecognizer *pan = [[ UIPanGestureRecognizer alloc ] initWithTarget:self action:@selector(panGestureRecognizerDidFire:)];
        [ self addGestureRecognizer:pan ];
    }
    return self;
}


-(void)test
{
    self.backgroundColor = [ UIColor blackColor ];
    
    
    NSArray *paths = [ UIBezierPath edgeSwipePathsForBounds:self.bounds edges:UIRectEdgeBottom | UIRectEdgeTop | UIRectEdgeLeft | UIRectEdgeRight ];
    
    [ self animatePaths:paths withDurations:@[ @( 0.2 ) ] intervals:@[ @( 1.0 )] index:0 ];
}



-(void)animatePaths:(NSArray *)paths withDurations:(NSArray *)durations intervals:(NSArray *)intervals index:(NSInteger)index
{
    NSParameterAssert( paths && paths.count && durations && durations.count && intervals && intervals.count );
    
    if( index < paths.count )
    {
        UIBezierPath *path = [ paths objectAtIndex:index ];
        
        CFTimeInterval duration = [[ durations objectAtIndex:index % durations.count ] doubleValue ];
        NSTimeInterval interval = [[ intervals objectAtIndex:index % intervals.count ] doubleValue ];
        
        [ self.animationLayer animateWithPath:path.CGPath duration:duration animation:^(CGPoint position) {
            
            [ self addTrailAtPosition:position ];
            
        }  completion:^{
        
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, interval * 1000.0 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
                
                [ self animatePaths:paths withDurations:durations intervals:intervals index:index + 1 ];
            });
        } ];
    }
}



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
    
    
    [ UIView animateWithDuration:1.0f animations:^{
        trail.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [ trail removeFromSuperview ];
    }];
}

@end
