//
//  AJDirectionsViewController.h
//  World Traveler
//
//  Created by Allan Jones on 9/17/14.
//  Copyright (c) 2014 Allan Jones. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Venue.h"
#import "Location.h"

@interface AJDirectionsViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *directionsMap;

@property (strong, nonatomic) Venue *venue;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSArray *steps;

//IBActions
- (IBAction)listDirectionsBarButtonItemPressed:(UIBarButtonItem *)sender;


@end
