//
//  UIBezierPath+GestureEyes.m
//  GestureEyes demo
//
//  Created by Nigel Barber on 21/12/2013.
//  Copyright (c) 2013 Nigel Barber (@mindbrix). All rights reserved.
//

#import "UIBezierPath+GestureEyes.h"

@implementation UIBezierPath (GestureEyes)

+(NSArray *)edgeSwipePathsForBounds:(CGRect)bounds edges:(UIRectEdge)edges
{
    NSMutableArray *paths = [ NSMutableArray new ];
    
    UIRectEdge edgeMasks[] = { UIRectEdgeTop, UIRectEdgeRight, UIRectEdgeBottom, UIRectEdgeLeft };
    
    for( NSInteger i = 0; i < 4; i++ )
    {
        UIRectEdge edgeMask = edgeMasks[ i ];
        
        UIBezierPath *path = [ UIBezierPath edgeSwipePathsForBounds:bounds edge:edges & edgeMask ];
        
        if( path )
        {
            [ paths addObject:path ];
        }
    }
    
    return [[ NSArray alloc ] initWithArray:paths ];
}


+(UIBezierPath *)edgeSwipePathsForBounds:(CGRect)bounds edge:(UIRectEdge)edge
{
    CGPoint endPoint = CGPointMake( bounds.size.width / 2.0f, bounds.size.height / 2.0f );
    
    CGPoint startPoint = CGPointZero;
    
    if( edge & UIRectEdgeTop )
    {
        startPoint = CGPointMake( endPoint.x, 0.0f );
    }
    else if( edge & UIRectEdgeRight )
    {
        startPoint = CGPointMake( bounds.size.width, endPoint.y );
    }
    else if( edge & UIRectEdgeBottom )
    {
        startPoint = CGPointMake( endPoint.x, bounds.size.height );
    }
    else if( edge & UIRectEdgeLeft )
    {
        startPoint = CGPointMake( 0.0f, endPoint.y );
    }
    
    if( startPoint.x == 0.0f && startPoint.y == 0.0f )
    {
        return nil;
    }
    
    UIBezierPath *path = [ UIBezierPath bezierPath ];
    [ path moveToPoint:startPoint ];
    [ path addLineToPoint:endPoint ];

    return path;
}
@end
