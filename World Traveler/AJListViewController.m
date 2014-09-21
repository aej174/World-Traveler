//
//  AJListViewController.m
//  World Traveler
//
//  Created by Allan Jones on 8/19/14.
//  Copyright (c) 2014 Allan Jones. All rights reserved.
//

#import "AJListViewController.h"
#import "AJFourSquareSessionManager.h"
#import "AFMMRecordResponseSerializer.h"
#import "AFMMRecordResponseSerializationMapper.h"
#import "Venue.h"
#import "Location.h"
#import "AJMapViewController.h"

static NSString *const kCLIENTID = @"VBFKYAPS32GOGN5HULNNA1CZ2SR4YVIMBQWI4UCWK0H4QJTD";
static NSString *const kCLIENTSECRET = @"FDYVPVWILLZS1PNPKEHLIYY34DWMY4XX0QKASKSD5IURQ0MJ";

#define latitudeOffset 0.01;
#define longitudeOffset 0.01;

@interface AJListViewController () <CLLocationManagerDelegate>

@property (strong, nonatomic) NSArray *venues;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation AJListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.locationManager.distanceFilter = 10.0;
    
    AJFourSquareSessionManager *sessionManager = [AJFourSquareSessionManager sharedClient];
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    
    AFHTTPResponseSerializer *HTTPResponseSerializer = [AFJSONResponseSerializer serializer];
    AFMMRecordResponseSerializationMapper *mapper = [[AFMMRecordResponseSerializationMapper alloc] init];
    [mapper registerEntityName:@"Venue" forEndpointPathComponent:@"venues/search?"];
    
    AFMMRecordResponseSerializer *serializer = [AFMMRecordResponseSerializer serializerWithManagedObjectContext:context responseObjectSerializer:HTTPResponseSerializer entityMapper:mapper];
    sessionManager.responseSerializer = serializer;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = sender;
    Venue *venue = self.venues[indexPath.row];
    AJMapViewController *mapVC = segue.destinationViewController;
    mapVC.venue = venue;
}

#pragma mark - IBActions

- (IBAction)refreshBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [self.locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    //NSLog(@"location is: %@", [locations lastObject]);
    
    [self.locationManager stopUpdatingLocation];
    
    [[AJFourSquareSessionManager sharedClient] GET:[NSString stringWithFormat:@"venues/search?ll=%f,%f",location.coordinate.latitude + latitudeOffset,location.coordinate.longitude +longitudeOffset] parameters:@{@"client_id" : kCLIENTID, @"client_secret" : kCLIENTSECRET, @"v" : @"20140915"} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *venues = responseObject;
        self.venues = venues;
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@",error);
    }];
    
    /*[[AJFourSquareSessionManager sharedClient] GET:[NSString stringWithFormat:@"venues/search?ll=%f,%f",location.coordinate.latitude + latitudeOffset,location.coordinate.longitude + longitudeOffset] parameters:@{@"client_id" : kCLIENTID, @"client_secret" : kCLIENTSECRET, @"v" : @"20140915"} success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSArray *venues = responseObject;
         self.venues = venues;
         [self.tableView reloadData];
     }
     failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];*/
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"Number of venues: %i", [self.venues count]);
    return [self.venues count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Venue *venue = self.venues[indexPath.row];
    cell.textLabel.text = venue.name;
    //NSLog(@"venue name is: %@", venue.name);
    cell.detailTextLabel.text = venue.location.address;
    
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"listToMapSegue" sender:indexPath];
}

@end
