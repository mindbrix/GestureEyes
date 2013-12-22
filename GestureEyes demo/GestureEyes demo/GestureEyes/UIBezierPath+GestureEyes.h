//
//  UIBezierPath+GestureEyes.h
//  GestureEyes demo
//
//  Created by Nigel Barber on 21/12/2013.
//  Copyright (c) 2013 Nigel Barber (@mindbrix). All rights reserved.
//

@import UIKit;

@interface UIBezierPath (GestureEyes)

+(NSArray *)rotationPathsForBounds:(CGRect)bounds;

+(NSArray *)swipePathsForBounds:(CGRect)bounds direction:(UISwipeGestureRecognizerDirection)direction numberOfTouchesRequired:(NSInteger)numberOfTouchesRequired;

+(NSArray *)edgePanPathsForBounds:(CGRect)bounds edges:(UIRectEdge)edges;

@end
