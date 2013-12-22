//
//  UIBezierPath+GestureEyes.m
//  GestureEyes demo
//
//  Created by Nigel Barber on 21/12/2013.
//  Copyright (c) 2013 Nigel Barber (@mindbrix). All rights reserved.
//

#import "UIBezierPath+GestureEyes.h"

@implementation UIBezierPath (GestureEyes)

+(NSArray *)swipePathsForBounds:(CGRect)bounds direction:(UISwipeGestureRecognizerDirection)direction numberOfTouchesRequired:(NSInteger)numberOfTouchesRequired
{
    NSMutableArray *paths = [ NSMutableArray new ];
    
    UIBezierPath *path = [ self swipePathForBounds:bounds direction:direction ];
    
    
    [ paths addObject:path ];
    
    return [[ NSArray alloc ] initWithArray:paths ];
}


+(UIBezierPath *)swipePathForBounds:(CGRect)bounds direction:(UISwipeGestureRecognizerDirection)direction
{
    CGPoint startPoint = CGPointZero;
    CGPoint endPoint = CGPointZero;
    
    if( direction & UISwipeGestureRecognizerDirectionRight )
    {
        startPoint = CGPointMake( bounds.size.width * 0.25f, bounds.size.height / 2.0f );
        endPoint = CGPointMake( bounds.size.width * 0.75f, startPoint.y );
    }
    else if( direction & UISwipeGestureRecognizerDirectionLeft )
    {
        startPoint = CGPointMake( bounds.size.width * 0.75f, bounds.size.height / 2.0f );
        endPoint = CGPointMake( bounds.size.width * 0.25f, startPoint.y );
    }
    else if( direction & UISwipeGestureRecognizerDirectionDown )
    {
        startPoint = CGPointMake( bounds.size.width / 2.0f, bounds.size.height * 0.25f );
        endPoint = CGPointMake( startPoint.x, bounds.size.height * 0.75f );
    }
    else if( direction & UISwipeGestureRecognizerDirectionUp )
    {
        startPoint = CGPointMake( bounds.size.width / 2.0f, bounds.size.height * 0.75f );
        endPoint = CGPointMake( startPoint.x, bounds.size.height * 0.25f );
    }
    
    if( startPoint.x == endPoint.x && startPoint.y == endPoint.y )
    {
        return nil;
    }
    
    UIBezierPath *path = [ UIBezierPath bezierPath ];
    [ path moveToPoint:startPoint ];
    [ path addLineToPoint:endPoint ];
    
    return path;
}


+(NSArray *)edgePanPathsForBounds:(CGRect)bounds edges:(UIRectEdge)edges
{
    NSMutableArray *paths = [ NSMutableArray new ];
    
    UIRectEdge edgeMasks[] = { UIRectEdgeTop, UIRectEdgeRight, UIRectEdgeBottom, UIRectEdgeLeft };
    
    for( NSInteger i = 0; i < 4; i++ )
    {
        UIRectEdge edgeMask = edgeMasks[ i ];
        
        UIBezierPath *path = [ UIBezierPath edgePanPathForBounds:bounds edge:edges & edgeMask ];
        
        if( path )
        {
            [ paths addObject:path ];
        }
    }
    
    return [[ NSArray alloc ] initWithArray:paths ];
}


+(UIBezierPath *)edgePanPathForBounds:(CGRect)bounds edge:(UIRectEdge)edge
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
