//
//  AJMapViewController.h
//  World Traveler
//
//  Created by Allan Jones on 8/21/14.
//  Copyright (c) 2014 Allan Jones. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Venue.h"

@interface AJMapViewController : UIViewController

//IBOutlets
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

//IBActions
- (IBAction)showDirectionsBarButtonItemPressed:(UIBarButtonItem *)sender;



@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) Venue *venue;

@end
