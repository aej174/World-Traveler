//
//  AJDirectionsViewController.m
//  World Traveler
//
//  Created by Allan Jones on 9/17/14.
//  Copyright (c) 2014 Allan Jones. All rights reserved.
//

#import "AJDirectionsViewController.h"

@interface AJDirectionsViewController ()

@end

@implementation AJDirectionsViewController

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
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)listDirectionsBarButtonItemPressed:(UIBarButtonItem *)sender
{
    
}

#pragma mark - CLLocationManagerDelegate

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    [manager stopUpdatingLocation];
    
    self.directionsMap.showsUserLocation = YES;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 3000, 3000);
    [self.directionsMap setRegion:[self.directionsMap regionThatFits:region] animated:YES];
    
    float latitude = [self.venue.location.lat floatValue];
    float longitude = [self.venue.location.lng floatValue];
    
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(latitude, longitude) addressDictionary:nil];
    MKMapItem *destinationMapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    
    [self getDirections:destinationMapItem];
}

#pragma mark - directions helper

- (void) getDirections:(MKMapItem *)destination
{
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    request.source = [MKMapItem mapItemForCurrentLocation];
    request.destination = destination;
    request.requestsAlternateRoutes = YES;
    
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if (error)
        {
            //do something with error
            NSLog(@"%@", error);
        }
        else [self showRoute:response];
    }];
}

#pragma mark - route helper

- (void) showRoute:(MKDirectionsResponse *)response
{
    self.steps = response.routes;
    NSLog(@"number of steps: %i", [self.steps count]);
    for (MKRoute *route in self.steps){
        for (MKRouteStep *step in route.steps){
            NSLog(@"Step instructions: %@",step.instructions);
        }
    }
}

@end
