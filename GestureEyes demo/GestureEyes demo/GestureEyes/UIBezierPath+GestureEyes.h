//
//  UIBezierPath+GestureEyes.h
//  GestureEyes demo
//
//  Created by Nigel Barber on 21/12/2013.
//  Copyright (c) 2013 Nigel Barber (@mindbrix). All rights reserved.
//

@import UIKit;

@interface UIBezierPath (GestureEyes)

+(NSArray *)edgeSwipePathsForBounds:(CGRect)bounds edges:(UIRectEdge)edges;

@end
