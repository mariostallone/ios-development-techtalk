//
//  MapViewController.m
//  MapFinder
//
//  Created by Mario on 24/07/13.
//  Copyright (c) 2013 Compassites. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    CLLocationCoordinate2D coordinate = {35.67106,139.764909};
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000);
    MKCoordinateRegion adjustedRegion = [self.myMapView regionThatFits:viewRegion];
    [self.myMapView setRegion:adjustedRegion animated:YES];
    [self.myMapView setCenterCoordinate:coordinate animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
