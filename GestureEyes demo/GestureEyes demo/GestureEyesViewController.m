//
//  GestureEyesViewController.m
//  GestureEyes demo
//
//  Created by Nigel Barber on 20/12/2013.
//  Copyright (c) 2013 Nigel Barber (@mindbrix). All rights reserved.
//

#import "GestureEyesViewController.h"

@interface GestureEyesViewController ()

@property( nonatomic, strong ) UIScrollView *scrollView;

@end

@implementation GestureEyesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.scrollView = [[ UIScrollView alloc ] initWithFrame:self.view.bounds ];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [ self.view addSubview:self.scrollView ];
    
    [ self layoutViews ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [ self layoutViews ];
}

-(void)layoutViews
{
    self.scrollView.contentSize = CGSizeMake( self.view.bounds.size.width * 2.0f, self.view.bounds.size.height * 2.0f );
}

@end
