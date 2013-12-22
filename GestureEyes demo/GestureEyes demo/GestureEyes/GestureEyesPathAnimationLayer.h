//
//  GestureEyesPathAnimator.h
//  GestureEyes demo
//
//  Created by Nigel Barber on 20/12/2013.
//  Copyright (c) 2013 Nigel Barber (@mindbrix). All rights reserved.
//

@import UIKit;

@interface GestureEyesPathAnimationLayer : CALayer

-(void)animatePaths:(NSArray *)paths withDurations:(NSArray *)durations intervals:(NSArray *)intervals animation:(void (^)( CGPoint position ))animationBlock completion:(void (^)(void))completionsBlock;

@end
