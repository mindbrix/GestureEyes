//
//  GestureEyesCALayerProxy.m
//  GestureEyes demo
//
//  Created by Nigel Barber on 20/12/2013.
//  Copyright (c) 2013 Nigel Barber (@mindbrix). All rights reserved.
//

#import "GestureEyesCALayerProxy.h"

@implementation GestureEyesCALayerProxy

-(void)setPosition:(CGPoint)position
{
    [ super setPosition:position ];
    
    NSLog( @"position = %@", NSStringFromCGPoint( position ));
}

@end
