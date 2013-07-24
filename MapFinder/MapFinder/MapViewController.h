//
//  MapViewController.h
//  MapFinder
//
//  Created by Mario on 24/07/13.
//  Copyright (c) 2013 Compassites. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *myMapView;
@property (strong, nonatomic) CLLocation *location;
@property (strong, nonatomic) NSString *place;

@end
