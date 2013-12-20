//
//  GestureEyesAnimator.m
//  GestureEyes demo
//
//  Created by Nigel Barber on 20/12/2013.
//  Copyright (c) 2013 Nigel Barber (@mindbrix). All rights reserved.
//

#import "GestureEyesAnimator.h"

#import "GestureEyesCALayerProxy.h"

@interface GestureEyesAnimator ()

@property( nonatomic, strong ) UIView *imageViewForAnimation;

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
    self.imageViewForAnimation = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 40.0f, 40.0f )];
    self.imageViewForAnimation.backgroundColor = [ UIColor redColor ];
    self.imageViewForAnimation.alpha = 1.0f;
    CGRect imageFrame = self.imageViewForAnimation.frame;
    //Your image frame.origin from where the animation need to get start
    CGPoint viewOrigin = self.imageViewForAnimation.frame.origin;
    viewOrigin.y = viewOrigin.y + imageFrame.size.height / 2.0f;
    viewOrigin.x = viewOrigin.x + imageFrame.size.width / 2.0f;
    
    self.imageViewForAnimation.frame = imageFrame;
    self.imageViewForAnimation.layer.position = viewOrigin;
    [self addSubview:self.imageViewForAnimation];
    
    // Set up fade out effect
    CABasicAnimation *fadeOutAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [fadeOutAnimation setToValue:[NSNumber numberWithFloat:0.3]];
    fadeOutAnimation.fillMode = kCAFillModeForwards;
    fadeOutAnimation.removedOnCompletion = NO;
    
    // Set up scaling
    CABasicAnimation *resizeAnimation = [CABasicAnimation animationWithKeyPath:@"bounds.size"];
    [resizeAnimation setToValue:[NSValue valueWithCGSize:CGSizeMake(40.0f, imageFrame.size.height * (40.0f / imageFrame.size.width))]];
    resizeAnimation.fillMode = kCAFillModeForwards;
    resizeAnimation.removedOnCompletion = NO;
    
    // Set up path movement
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    //Setting Endpoint of the animation
    CGPoint endPoint = CGPointMake(480.0f - 30.0f, 240.0f);
    //to end animation in last tab use
    //CGPoint endPoint = CGPointMake( 320-40.0f, 480.0f);
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, viewOrigin.x, viewOrigin.y);
    CGPathAddCurveToPoint(curvedPath, NULL, endPoint.x, viewOrigin.y, endPoint.x, viewOrigin.y, endPoint.x, endPoint.y);
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    [group setAnimations:[NSArray arrayWithObjects:fadeOutAnimation, pathAnimation, resizeAnimation, nil]];
    group.duration = 0.7f;
    group.delegate = self;
    [group setValue:self.imageViewForAnimation forKey:@"imageViewBeingAnimated"];
    
    [ self.imageViewForAnimation.layer addAnimation:group forKey:@"savingAnimation"];

    
    NSTimer *pollTimer = [ NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(pollPosition:) userInfo:Nil repeats:YES ];
    [[ NSRunLoop currentRunLoop ] addTimer:pollTimer forMode:NSRunLoopCommonModes ];
}


-(void)pollPosition:(id)sender
{
    CALayer *presentationLayer = self.imageViewForAnimation.layer.presentationLayer;
    
    NSLog( @"position = %@", NSStringFromCGPoint( presentationLayer.position ) );
}

@end
